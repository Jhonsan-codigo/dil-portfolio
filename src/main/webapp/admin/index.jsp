<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.util.PortfolioRepository" %>
<%
    PortfolioRepository repo = PortfolioRepository.getInstance();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin | DIL.PORTFOLIO</title>
    <link rel="stylesheet" href="../assets/css/red-style.css">
</head>
<body class="admin-body">
    <%@ include file="nav.jsp" %>

    <main class="admin-main">
        <div class="admin-title">
            <span class="eyebrow">Panel privado</span>
            <h1>Administración</h1>
            <p>Gestiona contenido, archivos y evidencias del portafolio.</p>
        </div>

        <div class="admin-grid">
            <a class="admin-card" href="semanas.jsp"><span>📅</span><h2><%= repo.getSemanas().size() %></h2><p>Semanas</p></a>
            <a class="admin-card" href="proyectos.jsp"><span>💻</span><h2><%= repo.getProyectos().size() %></h2><p>Proyectos</p></a>
            <a class="admin-card" href="sobre-mi.jsp"><span>👤</span><h2>Perfil</h2><p>Sobre mí</p></a>
            <div class="admin-card"><span>📎</span><h2><%= repo.getTotalArchivos() %></h2><p>Archivos subidos</p></div>
        </div>
    </main>
</body>
</html>
