<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.modelo.SobreMi,com.portafolio.modelo.Archivo,com.portafolio.util.PortfolioRepository" %>
<%
    PortfolioRepository repo = PortfolioRepository.getInstance();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");

        try {
            if ("actualizar".equals(accion)) {
                repo.actualizarSobreMi(request.getParameter("titulo"), request.getParameter("descripcion"), request.getParameter("intereses"));
            }

            if ("subirArchivo".equals(accion)) {
                repo.guardarArchivoSobreMi(request.getParameter("archivoNombre"), request.getParameter("archivoTipo"), request.getParameter("archivoBase64"));
            }

            if ("eliminarArchivo".equals(accion)) repo.eliminarArchivo(Integer.parseInt(request.getParameter("archivoId")));
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        response.sendRedirect("sobre-mi.jsp");
        return;
    }

    SobreMi sobreMi = repo.getSobreMi();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin Sobre mí</title>
    <link rel="stylesheet" href="../assets/css/red-style.css">
</head>
<body class="admin-body">
    <%@ include file="nav.jsp" %>

    <main class="admin-main">
        <div class="admin-title">
            <span class="eyebrow">Editar perfil</span>
            <h1>Sobre mí</h1>
            <p>Edita la información pública y sube archivos personales.</p>
        </div>

        <section class="admin-panel">
            <form class="admin-form" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <label>Título</label><input type="text" name="titulo" value="<%= sobreMi.getTitulo() %>" required>
                <label>Descripción</label><textarea name="descripcion" required><%= sobreMi.getDescripcion() %></textarea>
                <label>Intereses</label><textarea name="intereses" required><%= sobreMi.getIntereses() %></textarea>
                <button>Guardar información</button>
                <a class="btn btn-outline" href="../sobre-mi-download.jsp">Descargar texto</a>
            </form>
        </section>

        <section class="admin-panel">
            <h2>Archivos de Sobre mí</h2>
            <form class="js-file-form admin-form" method="post">
                <input type="hidden" name="accion" value="subirArchivo">
                <input type="hidden" name="archivoNombre">
                <input type="hidden" name="archivoTipo">
                <input type="hidden" name="archivoBase64">
                <input type="file" required>
                <button>Subir archivo</button>
            </form>

            <div class="files admin-files">
                <% if (sobreMi.getArchivos().isEmpty()) { %>
                    <em>No hay archivos.</em>
                <% } else { for (Archivo a : sobreMi.getArchivos()) { %>
                    <div>
                        <a href="../download.jsp?id=<%= a.getId() %>">⬇ <%= a.getNombreOriginal() %></a>
                        <form method="post"><input type="hidden" name="accion" value="eliminarArchivo"><input type="hidden" name="archivoId" value="<%= a.getId() %>"><button class="danger">Eliminar</button></form>
                    </div>
                <% }} %>
            </div>
        </section>
    </main>

    <script src="../assets/js/main-red.js"></script>
</body>
</html>
