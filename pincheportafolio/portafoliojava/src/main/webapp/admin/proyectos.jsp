<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.portafolio.modelo.Proyecto,com.portafolio.modelo.Archivo,com.portafolio.util.PortfolioRepository" %>
<%
    PortfolioRepository repo = PortfolioRepository.getInstance();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");

        try {
            if ("agregar".equals(accion)) {
                repo.agregarProyecto(request.getParameter("titulo"), request.getParameter("descripcion"), request.getParameter("tecnologia"), request.getParameter("estado"), request.getParameter("icono"));
            }

            if ("eliminar".equals(accion)) repo.eliminarProyecto(Integer.parseInt(request.getParameter("id")));

            if ("subirArchivo".equals(accion)) {
                repo.guardarArchivoProyecto(Integer.parseInt(request.getParameter("proyectoId")), request.getParameter("archivoNombre"), request.getParameter("archivoTipo"), request.getParameter("archivoBase64"));
            }

            if ("eliminarArchivo".equals(accion)) repo.eliminarArchivo(Integer.parseInt(request.getParameter("archivoId")));
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        response.sendRedirect("proyectos.jsp");
        return;
    }

    List<Proyecto> proyectos = repo.getProyectos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin Proyectos</title>
    <link rel="stylesheet" href="../assets/css/red-style.css">
</head>
<body class="admin-body">
    <%@ include file="nav.jsp" %>

    <main class="admin-main">
        <div class="admin-title">
            <span class="eyebrow">CRUD proyectos</span>
            <h1>Proyectos</h1>
            <p>Agrega, quita y administra archivos de proyectos.</p>
        </div>

        <section class="admin-panel">
            <h2>Agregar proyecto</h2>
            <form class="admin-form" method="post">
                <input type="hidden" name="accion" value="agregar">
                <label>Título</label><input type="text" name="titulo" required>
                <label>Descripción</label><textarea name="descripcion" required></textarea>
                <div class="form-row">
                    <div><label>Tecnología</label><input type="text" name="tecnologia" required></div>
                    <div><label>Estado</label><select name="estado"><option>Finalizado</option><option>En proceso</option><option>Pendiente</option></select></div>
                    <div><label>Icono</label><input type="text" name="icono" value="◈"></div>
                </div>
                <button>Agregar proyecto</button>
            </form>
        </section>

        <section class="admin-list">
            <% for (Proyecto p : proyectos) { %>
            <article class="admin-item">
                <div><span class="chapter"><%= p.getTecnologia() %></span><h3><%= p.getIcono() %> <%= p.getTitulo() %></h3><p><%= p.getDescripcion() %></p></div>

                <div class="admin-actions">
                    <form method="post" onsubmit="return confirm('¿Eliminar este proyecto?');">
                        <input type="hidden" name="accion" value="eliminar"><input type="hidden" name="id" value="<%= p.getId() %>"><button class="danger">Quitar</button>
                    </form>
                </div>

                <div class="upload-box">
                    <form class="js-file-form" method="post">
                        <input type="hidden" name="accion" value="subirArchivo">
                        <input type="hidden" name="proyectoId" value="<%= p.getId() %>">
                        <input type="hidden" name="archivoNombre">
                        <input type="hidden" name="archivoTipo">
                        <input type="hidden" name="archivoBase64">
                        <input type="file" required>
                        <button>Subir archivo</button>
                    </form>

                    <div class="files admin-files">
                        <% if (p.getArchivos().isEmpty()) { %>
                            <em>No hay archivos.</em>
                        <% } else { for (Archivo a : p.getArchivos()) { %>
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
