package com.portafolio.modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SobreMi implements Serializable {
    private static final long serialVersionUID = 1L;

    private String titulo;
    private String descripcion;
    private String intereses;
    private List<Archivo> archivos;

    public SobreMi() {
        titulo = "Sobre mí";
        descripcion = "Soy estudiante del curso Lenguaje de Programación. Este portafolio organiza mis evidencias, proyectos y avances académicos usando Java Web, JSP y un panel administrador.";
        intereses = "Programación Java, diseño web, automatización, inteligencia artificial visual, dashboard académico y desarrollo de sistemas.";
        archivos = new ArrayList<>();
    }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getIntereses() { return intereses; }
    public void setIntereses(String intereses) { this.intereses = intereses; }

    public List<Archivo> getArchivos() {
        if (archivos == null) archivos = new ArrayList<>();
        return archivos;
    }
}
