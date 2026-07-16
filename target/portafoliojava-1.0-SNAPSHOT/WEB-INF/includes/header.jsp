<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String pagina = (String) request.getAttribute("pagina");
    if (pagina == null) pagina = "";
    String ctx = request.getContextPath();
%>
<header class="site-header">
    <div class="nav-inner">
        <a class="brand" href="<%= ctx %>/index.jsp">
            <span class="brand-mark">D</span>
            <span>
                <strong>DIL<span>.PORTFOLIO</span></strong>
                <small>Lenguaje de Programación</small>
            </span>
        </a>

        <button class="menu-btn" id="menuBtn" type="button">☰</button>

        <nav class="main-nav" id="mainNav">
            <a class="nav-link <%= "inicio".equals(pagina) ? "active" : "" %>" href="<%= ctx %>/index.jsp">Home</a>
            <a class="nav-link <%= "dashboard".equals(pagina) ? "active" : "" %>" href="<%= ctx %>/dashboard.jsp">Dashboard</a>
            <a class="nav-link <%= "semanas".equals(pagina) ? "active" : "" %>" href="<%= ctx %>/semanas.jsp">Semanas</a>
            <a class="nav-link <%= "proyectos".equals(pagina) ? "active" : "" %>" href="<%= ctx %>/proyectos.jsp">Proyectos</a>
            <a class="nav-link <%= "sobre".equals(pagina) ? "active" : "" %>" href="<%= ctx %>/sobre-mi.jsp">Sobre mí</a>
            <a class="login-pill" href="<%= ctx %>/login.jsp">Login</a>
        </nav>
    </div>
</header>
