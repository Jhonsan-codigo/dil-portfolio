package com.portafolio.modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Proyecto implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String titulo;
    private String descripcion;
    private String tecnologia;
    private String estado;
    private String icono;
    private List<Archivo> archivos;

    public Proyecto(int id, String titulo, String descripcion, String tecnologia, String estado, String icono) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.tecnologia = tecnologia;
        this.estado = estado;
        this.icono = icono;
        this.archivos = new ArrayList<>();
    }

    public int getId() { return id; }
    public String getTitulo() { return titulo; }
    public String getDescripcion() { return descripcion; }
    public String getTecnologia() { return tecnologia; }
    public String getEstado() { return estado; }
    public String getIcono() { return icono; }

    public List<Archivo> getArchivos() {
        if (archivos == null) archivos = new ArrayList<>();
        return archivos;
    }

    public String getEstadoClase() {
        String valor = estado == null ? "" : estado.toLowerCase();
        if (valor.contains("finalizado") || valor.contains("completado")) return "completado";
        if (valor.contains("proceso")) return "proceso";
        return "pendiente";
    }
}
