<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.io.File,com.portafolio.modelo.Semana,com.portafolio.modelo.Archivo,com.portafolio.util.PortfolioRepository" %>
<%
    PortfolioRepository repo = PortfolioRepository.getInstance();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");

        try {
            if ("agregar".equals(accion)) {
                repo.agregarSemana(request.getParameter("tema"), request.getParameter("descripcion"), request.getParameter("evidencia"), request.getParameter("estado"), Integer.parseInt(request.getParameter("progreso")));
            }

            if ("eliminar".equals(accion)) repo.eliminarSemana(Integer.parseInt(request.getParameter("id")));
            if ("mover".equals(accion)) repo.moverSemana(Integer.parseInt(request.getParameter("id")), request.getParameter("direccion"));

            if ("subirArchivo".equals(accion)) {
                repo.guardarArchivoSemana(Integer.parseInt(request.getParameter("semanaId")), request.getParameter("archivoNombre"), request.getParameter("archivoTipo"), request.getParameter("archivoBase64"));
            }

            if ("eliminarArchivo".equals(accion)) repo.eliminarArchivo(Integer.parseInt(request.getParameter("archivoId")));
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        response.sendRedirect("semanas.jsp");
        return;
    }

    List<Semana> semanas = repo.getSemanas();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin Semanas</title>
    <link rel="stylesheet" href="../assets/css/red-style.css">
</head>
<body class="admin-body">
    <%@ include file="nav.jsp" %>

    <main class="admin-main">
        <div class="admin-title">
            <span class="eyebrow">CRUD semanas</span>
            <h1>Semanas</h1>
            <p>Agrega, quita, sube/baja orden y administra archivos de forma persistente.</p>
        </div>

        <section class="admin-panel">
            <h2>Agregar semana</h2>
            <form class="admin-form" method="post" action="semanas.jsp">
                <input type="hidden" name="accion" value="agregar">
                <label>Tema</label><input type="text" name="tema" required>
                <label>Descripción</label><textarea name="descripcion" required></textarea>
                <label>Evidencia</label><input type="text" name="evidencia" required>
                <div class="form-row">
                    <div><label>Estado</label><select name="estado"><option>Completado</option><option>En proceso</option><option>Pendiente</option></select></div>
                    <div><label>Progreso %</label><input type="number" name="progreso" min="0" max="100" value="0"></div>
                </div>
                <button type="submit">Agregar semana</button>
            </form>
        </section>

        <section class="admin-list">
            <% for (Semana s : semanas) { 
                String numSemana = String.format("%02d", s.getNumero());
                
                // --- DETECCIÓN FÍSICA MULTI-RECURSO ---
                String rutaBaseReal = request.getServletContext().getRealPath("/assets/archivos");
                if (rutaBaseReal == null) {
                    rutaBaseReal = "C:\\xampp\\tomcat\\webapps\\portafoliojava-1.0-SNAPSHOT\\assets\\archivos";
                }
                
                File dir = new File(rutaBaseReal);
                
                // 1. Detección de PDF (soporta .pdf y .pdf.pdf)
                String pdfEncontrado = null;
                if (new File(dir, "semana" + numSemana + ".pdf").exists()) {
                    pdfEncontrado = "semana" + numSemana + ".pdf";
                } else if (new File(dir, "semana" + numSemana + ".pdf.pdf").exists()) {
                    pdfEncontrado = "semana" + numSemana + ".pdf.pdf";
                }

                // 2. Detección de ZIP
                String zipEncontrado = null;
                if (new File(dir, "semana" + numSemana + ".zip").exists()) {
                    zipEncontrado = "semana" + numSemana + ".zip";
                }

                // 3. Detección de Imagen (.jpeg, .jpg, .png)
                String imgEncontrada = null;
                String[] extensionesImg = {".jpeg", ".jpg", ".png", ".jpg.jpeg"};
                for (String ext : extensionesImg) {
                    if (new File(dir, "semana" + numSemana + ext).exists()) {
                        imgEncontrada = "semana" + numSemana + ext;
                        break;
                    }
                }
            %>
            <article class="admin-item">
                <div>
                    <span class="chapter">Semana <%= numSemana %></span>
                    <h3><%= s.getTema() %></h3>
                    <p><%= s.getDescripcion() %></p>
                </div>

                <div class="admin-actions">
                    <form method="post"><input type="hidden" name="accion" value="mover"><input type="hidden" name="id" value="<%= s.getId() %>"><input type="hidden" name="direccion" value="up"><button>Subir</button></form>
                    <form method="post"><input type="hidden" name="accion" value="mover"><input type="hidden" name="id" value="<%= s.getId() %>"><input type="hidden" name="direccion" value="down"><button>Bajar</button></form>
                    <form method="post" onsubmit="return confirm('¿Eliminar esta semana?');"><input type="hidden" name="accion" value="eliminar"><input type="hidden" name="id" value="<%= s.getId() %>"><button class="danger">Quitar</button></form>
                </div>

                <!-- Bloque de recursos estáticos y subida interactiva -->
                <div class="upload-zone" style="margin-top: 15px; border-top: 1px solid #222; padding-top: 15px;">
                    
                    <!-- Botones dinámicos según los archivos encontrados -->
                    <div style="margin-bottom: 15px; display: flex; gap: 10px; flex-wrap: wrap;">
                        <% if (pdfEncontrado != null) { %>
                            <a href="${pageContext.request.contextPath}/assets/archivos/<%= pdfEncontrado %>" download target="_blank" style="display: inline-block; background: #221a24; border: 1px solid #3a2233; color: #ff4a5a; padding: 8px 12px; border-radius: 6px; text-decoration: none; font-weight: 500; font-size: 13px;">
                                📄 Descargar PDF (<%= pdfEncontrado %>)
                            </a>
                        <% } %>

                        <% if (zipEncontrado != null) { %>
                            <a href="${pageContext.request.contextPath}/assets/archivos/<%= zipEncontrado %>" download target="_blank" style="display: inline-block; background: #221a24; border: 1px solid #3a2233; color: #ff4a5a; padding: 8px 12px; border-radius: 6px; text-decoration: none; font-weight: 500; font-size: 13px;">
                                📦 Descargar ZIP (<%= zipEncontrado %>)
                            </a>
                        <% } %>

                        <% if (imgEncontrada != null) { %>
                            <a href="${pageContext.request.contextPath}/assets/archivos/<%= imgEncontrada %>" target="_blank" style="display: inline-block; background: #221a24; border: 1px solid #3a2233; color: #ff4a5a; padding: 8px 12px; border-radius: 6px; text-decoration: none; font-weight: 500; font-size: 13px;">
                                👁 Ver Imagen (<%= imgEncontrada %>)
                            </a>
                        <% } %>

                        <% if (pdfEncontrado == null && zipEncontrado == null && imgEncontrada == null) { %>
                            <span style="color: #666; font-size: 12px;">No se encontraron archivos estáticos para esta semana.</span>
                        <% } %>
                    </div>

                    <!-- Caja interactiva para subir archivos adicionales -->
                    <div style="background: #16111a; padding: 12px; border-radius: 6px; border: 1px solid #2a1b26; margin-bottom: 15px;">
                        <span style="display: block; color: #aaa; font-size: 13px; margin-bottom: 8px; font-weight: 500;">Subir archivos adicionales o comprimidos (.zip):</span>
                        <div style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap;">
                            <input type="file" id="file_<%= s.getId() %>" style="color: #ccc; font-size: 13px;">
                            <button type="button" onclick="procesarArchivo(<%= s.getId() %>)" style="background-color: #ff4a5a; color: white; padding: 6px 14px; border: none; cursor: pointer; border-radius: 4px; font-weight: bold; font-size: 13px;">
                                Subir archivo
                            </button>
                        </div>
                    </div>

                    <!-- Formulario oculto que envía el Base64 al backend -->
                    <form id="form_file_<%= s.getId() %>" method="post" action="semanas.jsp">
                        <input type="hidden" name="accion" value="subirArchivo">
                        <input type="hidden" name="semanaId" value="<%= s.getId() %>">
                        <input type="hidden" name="archivoNombre" id="name_<%= s.getId() %>">
                        <input type="hidden" name="archivoTipo" id="type_<%= s.getId() %>">
                        <input type="hidden" name="archivoBase64" id="base64_<%= s.getId() %>">
                    </form>

                    <!-- Archivos subidos dinámicamente -->
                    <div class="files admin-files">
                        <% if (!s.getArchivos().isEmpty()) { 
                            for (Archivo a : s.getArchivos()) { %>
                            <div style="display: flex; justify-content: space-between; align-items: center; background: #111; padding: 8px; margin-bottom: 5px; border-radius: 4px; border-left: 3px solid #ff4a5a;">
                                <a href="../download.jsp?id=<%= a.getId() %>" style="color: #ff4a5a; text-decoration: none; font-size: 13px;">⬇ <%= a.getNombreOriginal() %> (Memoria)</a>
                                <form method="post" style="display:inline;"><input type="hidden" name="accion" value="eliminarArchivo"><input type="hidden" name="archivoId" value="<%= a.getId() %>"><button class="danger" style="padding: 2px 8px; font-size: 12px;">Eliminar</button></form>
                            </div>
                        <%   } 
                           } %>
                    </div>
                </div>
            </article>
            <% } %>
        </section>
    </main>

    <script src="../assets/js/main-red.js"></script>
    <script>
        function procesarArchivo(semanaId) {
            const fileInput = document.getElementById('file_' + semanaId);
            if (!fileInput.files || fileInput.files.length === 0) {
                alert('Por favor, selecciona un archivo primero.');
                return;
            }

            const archivo = fileInput.files[0];
            const reader = new FileReader();

            reader.onload = function(e) {
                document.getElementById('name_' + semanaId).value = archivo.name;
                document.getElementById('type_' + semanaId).value = archivo.type;
                document.getElementById('base64_' + semanaId).value = e.target.result;
                document.getElementById('form_file_' + semanaId).submit();
            };

            reader.readAsDataURL(archivo);
        }
    </script>
</body>
</html>