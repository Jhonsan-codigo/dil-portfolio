<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.modelo.SobreMi" %>
<%@ page import="com.portafolio.modelo.Archivo" %>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    request.setAttribute("pagina", "sobre");
    SobreMi sobreMi = PortfolioRepository.getInstance().getSobreMi();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sobre mí | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <main class="page section about">
        <div class="section-title reveal">
            <span class="eyebrow">Perfil académico</span>
            <h2><%= sobreMi.getTitulo() %></h2>
            <p><%= sobreMi.getDescripcion() %></p>
            <a class="btn btn-primary" href="sobre-mi-download.jsp">Descargar información</a>
        </div>

        <article class="glass-panel reveal">
            <h3>Intereses</h3>
            <p><%= sobreMi.getIntereses() %></p>

            <div class="files">
                <strong>Archivos personales:</strong>
                <% if (sobreMi.getArchivos().isEmpty()) { %>
                    <em>Sin archivos.</em>
                <% } else { for (Archivo a : sobreMi.getArchivos()) { %>
                    <a href="download.jsp?id=<%= a.getId() %>">⬇ <%= a.getNombreOriginal() %> <small><%= a.getTamanoLegible() %></small></a>
                <% }} %>
            </div>
        </article>
    </main>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>
