<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.portafolio.util.AdminUserStore" %>
<%
    String error = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String correoPrefix = request.getParameter("correoPrefix");
        String clave = request.getParameter("clave");

        if (correoPrefix == null || correoPrefix.trim().isEmpty()) {
            error = "Escribe el usuario del correo.";
        } else {
            correoPrefix = correoPrefix.trim().toLowerCase();

            if (!correoPrefix.matches("[a-zA-Z0-9._-]+")) {
                error = "Solo puedes usar letras, números, punto, guion y guion bajo.";
            } else {
                String correo = correoPrefix + "@insti.edu.pe";
                AdminUserStore.getInstance().registrar(correo, clave);
                response.sendRedirect("login.jsp?registrado=1");
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear cuenta | DIL.PORTFOLIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/red-style.css">
</head>
<body>
    <canvas id="ai-bg"></canvas>

    <main class="register-main">
        <section class="register-shell reveal">
            <div class="register-copy">
                <span class="eyebrow">Start for free</span>
                <h1>Create new account<span>.</span></h1>
                <p>El correo se creará automáticamente con dominio institucional.</p>
            </div>

            <form class="register-card" method="post" action="registro.jsp">
                <h2>Crear cuenta</h2>
                <p>Dominio obligatorio: @insti.edu.pe</p>

                <% if (error != null) { %><div class="alert"><%= error %></div><% } %>

                <div class="double">
                    <div><label>Nombres</label><input type="text" name="nombres" placeholder="Dilber" required></div>
                    <div><label>Apellidos</label><input type="text" name="apellidos" placeholder="Lopez" required></div>
                </div>

                <label>Usuario del correo</label>
                <div class="email-builder">
                    <input type="text" name="correoPrefix" value="admin" required>
                    <span>@insti.edu.pe</span>
                </div>

                <label>Contraseña</label>
                <input type="password" name="clave" value="admin123" required>

                <button type="submit">Create account</button>
                <a href="login.jsp">Ya tengo cuenta · Login</a>
            </form>
        </section>
    </main>

    <script src="assets/js/particles-red.js"></script>
    <script src="assets/js/main-red.js"></script>
</body>
</html>
