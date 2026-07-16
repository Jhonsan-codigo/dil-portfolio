# Usar imagen oficial de Tomcat con JDK 17
FROM tomcat:10.1-jdk17

# Eliminar aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el WAR generado por Maven como ROOT.war
COPY target/portafoliojava-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Exponer puerto 8080
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
