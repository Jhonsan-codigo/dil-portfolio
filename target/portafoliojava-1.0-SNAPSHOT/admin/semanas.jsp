<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.portafolio.modelo.Semana,com.portafolio.modelo.Archivo,com.portafolio.util.PortfolioRepository" %>
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
            <p>Agrega, quita, sube/baja orden y administra archivos.</p>
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
            <% for (Semana s : semanas) { %>
            <article class="admin-item">
                <div>
                    <span class="chapter">Semana <%= String.format("%02d", s.getNumero()) %></span>
                    <h3><%= s.getTema() %></h3>
                    <p><%= s.getDescripcion() %></p>
                </div>

                <div class="admin-actions">
                    <form method="post"><input type="hidden" name="accion" value="mover"><input type="hidden" name="id" value="<%= s.getId() %>"><input type="hidden" name="direccion" value="up"><button>Subir</button></form>
                    <form method="post"><input type="hidden" name="accion" value="mover"><input type="hidden" name="id" value="<%= s.getId() %>"><input type="hidden" name="direccion" value="down"><button>Bajar</button></form>
                    <form method="post" onsubmit="return confirm('¿Eliminar esta semana?');"><input type="hidden" name="accion" value="eliminar"><input type="hidden" name="id" value="<%= s.getId() %>"><button class="danger">Quitar</button></form>
                </div>

                <div class="upload-box">
                    <form class="js-file-form" method="post" action="semanas.jsp">
                        <input type="hidden" name="accion" value="subirArchivo">
                        <input type="hidden" name="semanaId" value="<%= s.getId() %>">
                        <input type="hidden" name="archivoNombre">
                        <input type="hidden" name="archivoTipo">
                        <input type="hidden" name="archivoBase64">
                        <input type="file" required>
                        <button>Subir archivo</button>
                    </form>

                    <div class="files admin-files">
                        <% if (s.getArchivos().isEmpty()) { %>
                            <em>No hay archivos.</em>
                        <% } else { for (Archivo a : s.getArchivos()) { %>
                            <div>
                                <a href="../download.jsp?id=<%= a.getId() %>">⬇ <%= a.getNombreOriginal() %></a>
                                <form method="post"><input type="hidden" name="accion" value="eliminarArchivo"><input type="hidden" name="archivoId" value="<%= a.getId() %>"><button class="danger">Eliminar</button></form>
                            </div>
                        <% }} %>
                    </div>
                </div>
            </article>
            <% } %>
        </section>
    </main>

    <script src="../assets/js/main-red.js"></script>
</body>
</html>
