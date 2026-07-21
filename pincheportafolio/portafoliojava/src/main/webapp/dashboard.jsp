<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.modelo.Semana" %>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    request.setAttribute("pagina", "dashboard");
    PortfolioRepository repo = PortfolioRepository.getInstance();

    int totalSemanas = repo.getSemanas().size();
    int proyectos = repo.getProyectos().size();
    int evidencias = repo.getTotalArchivos();
    int suma = 0;
    for (Semana s : repo.getSemanas()) suma += s.getProgreso();
    int progreso = totalSemanas == 0 ? 0 : suma / totalSemanas;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <main class="page section">
        <div class="section-title reveal">
            <span class="eyebrow">Panel académico</span>
            <h2>Dashboard</h2>
            <p>Resumen del portafolio y administración de evidencias.</p>
        </div>

        <div class="dashboard-grid">
            <article class="dash-card reveal"><span>📅</span><h3><%= totalSemanas %></h3><p>Semanas</p></article>
            <article class="dash-card reveal"><span>📎</span><h3><%= evidencias %></h3><p>Archivos</p></article>
            <article class="dash-card reveal"><span>💻</span><h3><%= proyectos %></h3><p>Proyectos</p></article>
            <article class="dash-card reveal"><span>◎</span><h3><%= progreso %>%</h3><p>Progreso general</p></article>
        </div>
    </main>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>
