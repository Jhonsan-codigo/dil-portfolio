<%@ page import="java.nio.charset.StandardCharsets,com.portafolio.modelo.SobreMi,com.portafolio.util.PortfolioRepository" %><%
    SobreMi sm = PortfolioRepository.getInstance().getSobreMi();

    String contenido = sm.getTitulo() + "\n\n" + sm.getDescripcion() + "\n\nIntereses:\n" + sm.getIntereses();
    byte[] bytes = contenido.getBytes(StandardCharsets.UTF_8);

    response.reset();
    response.setContentType("text/plain; charset=UTF-8");
    response.setHeader("Content-Disposition", "attachment; filename=\"sobre-mi.txt\"");
    response.setContentLength(bytes.length);
    response.getOutputStream().write(bytes);
    return;
%>