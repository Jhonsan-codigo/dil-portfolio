package com.portafolio.modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Semana implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int numero;
    private String tema;
    private String descripcion;
    private String evidencia;
    private String estado;
    private int progreso;
    private List<Archivo> archivos;

    public Semana(int id, int numero, String tema, String descripcion, String evidencia, String estado, int progreso) {
        this.id = id;
        this.numero = numero;
        this.tema = tema;
        this.descripcion = descripcion;
        this.evidencia = evidencia;
        this.estado = estado;
        this.progreso = progreso;
        this.archivos = new ArrayList<>();
    }

    public int getId() { return id; }
    public int getNumero() { return numero; }
    public void setNumero(int numero) { this.numero = numero; }
    public String getTema() { return tema; }
    public String getDescripcion() { return descripcion; }
    public String getEvidencia() { return evidencia; }
    public String getEstado() { return estado; }
    public int getProgreso() { return progreso; }

    public List<Archivo> getArchivos() {
        if (archivos == null) archivos = new ArrayList<>();
        return archivos;
    }

    public String getEstadoClase() {
        String valor = estado == null ? "" : estado.toLowerCase();
        if (valor.contains("completado")) return "completado";
        if (valor.contains("proceso")) return "proceso";
        return "pendiente";
    }
}
