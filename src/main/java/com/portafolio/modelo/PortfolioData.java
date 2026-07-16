package com.portafolio.modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PortfolioData implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<Semana> semanas;
    private List<Proyecto> proyectos;
    private SobreMi sobreMi;
    private int nextSemanaId;
    private int nextProyectoId;
    private int nextArchivoId;

    public PortfolioData() {
        semanas = new ArrayList<>();
        proyectos = new ArrayList<>();
        sobreMi = new SobreMi();
        nextSemanaId = 1;
        nextProyectoId = 1;
        nextArchivoId = 1;
    }

    public List<Semana> getSemanas() { return semanas; }
    public List<Proyecto> getProyectos() { return proyectos; }
    public SobreMi getSobreMi() { return sobreMi; }
    public int nextSemanaId() { return nextSemanaId++; }
    public int nextProyectoId() { return nextProyectoId++; }
    public int nextArchivoId() { return nextArchivoId++; }
}
