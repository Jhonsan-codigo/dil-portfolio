<%@ page import="java.io.File,java.io.FileInputStream,java.net.URLEncoder,java.nio.charset.StandardCharsets,com.portafolio.modelo.Archivo,com.portafolio.util.PortfolioRepository" %><%
    int id = 0;
    try { id = Integer.parseInt(request.getParameter("id")); } catch (Exception e) {}

    Archivo archivo = PortfolioRepository.getInstance().buscarArchivo(id);

    if (archivo == null) {
        response.sendError(404, "Archivo no encontrado");
        return;
    }

    File file = new File(archivo.getRutaGuardada());

    if (!file.exists()) {
        response.sendError(404, "Archivo físico no encontrado");
        return;
    }

    String nombre = URLEncoder.encode(archivo.getNombreOriginal(), StandardCharsets.UTF_8.toString()).replace("+", "%20");
    response.reset();
    response.setContentType(archivo.getTipo() == null ? "application/octet-stream" : archivo.getTipo());
    response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + nombre);
    response.setContentLengthLong(file.length());

    try (FileInputStream in = new FileInputStream(file)) {
        byte[] buffer = new byte[8192];
        int len;
        while ((len = in.read(buffer)) != -1) {
            response.getOutputStream().write(buffer, 0, len);
        }
    }
    return;
%>