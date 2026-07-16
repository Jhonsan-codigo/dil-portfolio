<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.portafolio.modelo.Semana" %>
<%@ page import="com.portafolio.modelo.Archivo" %>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    request.setAttribute("pagina", "semanas");
    List<Semana> semanas = PortfolioRepository.getInstance().getSemanas();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Semanas | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <main class="page section">
        <div class="section-title reveal">
            <span class="eyebrow">Ruta académica</span>
            <h2>Semanas</h2>
            <p>Lista pública de semanas y archivos descargables.</p>
        </div>

        <div class="content-grid">
            <% for (Semana s : semanas) { %>
            <article class="content-card reveal">
                <span class="chapter">SEMANA <%= String.format("%02d", s.getNumero()) %></span>
                <h3><%= s.getTema() %></h3>
                <p><%= s.getDescripcion() %></p>
                <small class="<%= s.getEstadoClase() %>"><%= s.getEstado() %></small>
                <div class="progress"><span style="width:<%= s.getProgreso() %>%"></span></div>

                <div class="files">
                    <strong>Archivos:</strong>
                    <% if (s.getArchivos().isEmpty()) { %>
                        <em>Sin archivos.</em>
                    <% } else { for (Archivo a : s.getArchivos()) { %>
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
