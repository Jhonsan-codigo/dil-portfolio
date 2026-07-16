package com.portafolio.modelo;

import java.io.Serializable;

public class Archivo implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nombreOriginal;
    private String rutaGuardada;
    private String tipo;
    private long tamano;

    public Archivo(int id, String nombreOriginal, String rutaGuardada, String tipo, long tamano) {
        this.id = id;
        this.nombreOriginal = nombreOriginal;
        this.rutaGuardada = rutaGuardada;
        this.tipo = tipo;
        this.tamano = tamano;
    }

    public int getId() { return id; }
    public String getNombreOriginal() { return nombreOriginal; }
    public String getRutaGuardada() { return rutaGuardada; }
    public String getTipo() { return tipo; }
    public long getTamano() { return tamano; }

    public String getTamanoLegible() {
        if (tamano < 1024) return tamano + " B";
        if (tamano < 1024 * 1024) return String.format("%.1f KB", tamano / 1024.0);
        return String.format("%.1f MB", tamano / (1024.0 * 1024.0));
    }
}
