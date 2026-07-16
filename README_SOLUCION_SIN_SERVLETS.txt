VERSIÓN SIN SERVLETS - SOLUCIÓN DEFINITIVA PARA LOS ERRORES ROJOS

Se eliminó por completo el paquete com.portafolio.controlador.
Ya no hay archivos Servlet.java.
Por eso NetBeans ya no tendrá errores rojos de:
- jakarta.servlet
- HttpServlet
- HttpServletRequest
- HttpServletResponse
- ServletException
- WebServlet
- MultipartConfig

Todo funciona con JSP + clases Java normales:
- com.portafolio.modelo
- com.portafolio.util

RUTAS:
- index.jsp
- login.jsp
- registro.jsp
- dashboard.jsp
- semanas.jsp
- proyectos.jsp
- sobre-mi.jsp
- admin/index.jsp
- admin/semanas.jsp
- admin/proyectos.jsp
- admin/sobre-mi.jsp

LOGIN:
Correo: admin@insti.edu.pe
Contraseña: admin123

SUBIDA DE ARCHIVOS:
Funciona por Base64 desde JavaScript, para evitar MultipartConfig y evitar errores de servlet.
Los archivos se guardan en:
C:\Users\TU_USUARIO\PortafolioJSPData

PASOS:
1. Cierra el proyecto anterior.
2. Descomprime este ZIP.
3. Abre la carpeta portafoliojava_JSP_SIN_SERVLETS en NetBeans.
4. Clean and Build.
5. Run.

NOTA:
Ya no uses las versiones anteriores que tenían com.portafolio.controlador.
