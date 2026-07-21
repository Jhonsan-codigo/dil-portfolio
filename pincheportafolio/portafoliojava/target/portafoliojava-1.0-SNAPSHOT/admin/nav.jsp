<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean ok = (Boolean) session.getAttribute("adminLogueado");
    if (ok == null || !ok) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<aside class="admin-sidebar">
    <div class="admin-brand"><span>D</span><strong>DIL.ADMIN</strong></div>
    <nav>
        <a href="index.jsp">Dashboard</a>
        <a href="semanas.jsp">Semanas</a>
        <a href="proyectos.jsp">Proyectos</a>
        <a href="sobre-mi.jsp">Sobre mí</a>
        <a href="../index.jsp">Ver web</a>
        <a class="danger-link" href="logout.jsp">Cerrar sesión</a>
    </nav>
</aside>
