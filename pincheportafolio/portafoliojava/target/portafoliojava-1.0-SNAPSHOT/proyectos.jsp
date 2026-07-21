<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.portafolio.modelo.Proyecto" %>
<%@ page import="com.portafolio.modelo.Archivo" %>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    request.setAttribute("pagina", "proyectos");
    List<Proyecto> proyectos = PortfolioRepository.getInstance().getProyectos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Proyectos | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <main class="page section">
        <div class="section-title reveal">
            <span class="eyebrow">Galería de proyectos</span>
            <h2>Proyectos</h2>
            <p>Trabajos y evidencias del curso.</p>
        </div>

        <div class="content-grid">
            <% for (Proyecto p : proyectos) { %>
            <article class="content-card reveal">
                <div class="project-icon"><%= p.getIcono() %></div>
                <span class="chapter"><%= p.getTecnologia() %></span>
                <h3><%= p.getTitulo() %></h3>
                <p><%= p.getDescripcion() %></p>
                <small class="<%= p.getEstadoClase() %>"><%= p.getEstado() %></small>

                <div class="files">
                    <strong>Archivos:</strong>
                    <% if (p.getArchivos().isEmpty()) { %>
                        <em>Sin archivos.</em>
                    <% } else { for (Archivo a : p.getArchivos()) { %>
                        <a href="download.jsp?id=<%= a.getId() %>">⬇ <%= a.getNombreOriginal() %> <small><%= a.getTamanoLegible() %></small></a>
                    <% }} %>
                </div>
            </article>
            <% } %>
        </div>
    </main>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>
