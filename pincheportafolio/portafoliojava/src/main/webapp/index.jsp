<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.portafolio.modelo.Semana" %>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    request.setAttribute("pagina", "inicio");
    List<Semana> semanas = PortfolioRepository.getInstance().getSemanas();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>DIL.PORTFOLIO | IA</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <main>
        <section class="hero">
            <div class="hero-content reveal">
                <span class="eyebrow">Red Color Palettes · #730c1e #210207 #480415 #140f17</span>
                <h1>PORTAFOLIO<br><span>ACADÉMICO</span></h1>
                <p>Bitácora visual de aprendizaje para el curso Lenguaje de Programación: semanas, evidencias, proyectos y administración con Java Web.</p>
                <div class="hero-actions">
                    <a class="btn btn-primary" href="login.jsp">Ingresar admin</a>
                    <a class="btn btn-outline" href="semanas.jsp">Ver semanas</a>
                </div>
            </div>

            <div class="hero-panel reveal" style="display: flex; align-items: center; justify-content: center; background: transparent; border: none; box-shadow: none;">
                <img src="assets/img/gato-inteligente.png" alt="Gato Inteligente" style="max-width: 100%; max-height: 320px; object-fit: contain; filter: drop-shadow(0 0 15px rgba(115, 12, 30, 0.4));">
            </div>
        </section>

        <section class="section">
            <div class="section-title reveal">
                <span class="eyebrow">Enfoque técnico</span>
                <h2>Semanas del curso</h2>
                <p>Esta sección se actualiza desde el panel administrador.</p>
            </div>

            <div class="content-grid">
                <% for (Semana s : semanas) { %>
                <article class="content-card reveal">
                    <span class="chapter">SEMANA <%= String.format("%02d", s.getNumero()) %></span>
                    <h3><%= s.getTema() %></h3>
                    <p><%= s.getDescripcion() %></p>
                    <div class="progress"><span style="width:<%= s.getProgreso() %>%"></span></div>
                </article>
                <% } %>
            </div>
        </section>
    </main>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>