<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.util.AdminUserStore" %>
<%
    String error = null;
    String registrado = request.getParameter("registrado");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        if (AdminUserStore.getInstance().validar(usuario, clave)) {
            session.setAttribute("adminLogueado", true);
            session.setAttribute("adminNombre", usuario);
            response.sendRedirect("admin/index.jsp");
            return;
        } else {
            error = "Correo o contraseña incorrectos.";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body class="login-scene">
    <canvas id="ai-bg"></canvas>

    <header class="login-top">
        <a class="login-logo" href="index.jsp">DIL<span>.PORTFOLIO</span></a>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="sobre-mi.jsp">About</a>
            <a href="proyectos.jsp">Projects</a>
            <a class="login-nav-pill" href="registro.jsp">Register</a>
        </nav>
    </header>

    <main class="login-main">
        <form class="forest-login-card reveal" method="post" action="login.jsp">
            <a class="close-login" href="index.jsp">×</a>
            <h1>Login</h1>
            <p>Acceso al panel administrador.</p>

            <% if (error != null) { %><div class="alert"><%= error %></div><% } %>
            <% if (registrado != null) { %><div class="success">Cuenta creada correctamente.</div><% } %>

            <label>Email</label>
            <input type="email" name="usuario" required placeholder="admin@insti.edu.pe">

            <label>Password</label>
            <input type="password" name="clave" required placeholder="admin123">

            <div class="login-options">
                <label class="check"><input type="checkbox" checked><span>Remember me</span></label>
                <a href="registro.jsp">Crear cuenta</a>
            </div>

            <button type="submit">Login</button>
        </form>
    </main>

    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>
