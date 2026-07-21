package com.portafolio.util;

import com.portafolio.modelo.Archivo;
import com.portafolio.modelo.PortfolioData;
import com.portafolio.modelo.Proyecto;
import com.portafolio.modelo.Semana;
import com.portafolio.modelo.SobreMi;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Comparator;
import java.util.List;

public class PortfolioRepository {
    private static final PortfolioRepository INSTANCE = new PortfolioRepository();

    private final File dataDir;
    private final File uploadsDir;
    private final File dataFile;
    private PortfolioData data;

    private PortfolioRepository() {
        dataDir = new File(System.getProperty("user.home"), "PortafolioJSPData");
        uploadsDir = new File(dataDir, "uploads");
        dataFile = new File(dataDir, "data.ser");
        cargar();
    }

    public static PortfolioRepository getInstance() { return INSTANCE; }

    private synchronized void cargar() {
        try {
            if (!dataDir.exists()) dataDir.mkdirs();
            if (!uploadsDir.exists()) uploadsDir.mkdirs();

            if (dataFile.exists()) {
                try (ObjectInputStream in = new ObjectInputStream(new FileInputStream(dataFile))) {
                    data = (PortfolioData) in.readObject();
                }
                // Fuerza la inyección automática de las semanas que falten hasta la 14
                agregarSemanasFaltantes();
            } else {
                data = new PortfolioData();
                cargarInicial();
                guardar();
            }
        } catch (Exception e) {
            data = new PortfolioData();
            cargarInicial();
            guardar();
        }
    }

    private synchronized void guardar() {
        try {
            if (!dataDir.exists()) dataDir.mkdirs();
            try (ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(dataFile))) {
                out.writeObject(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void cargarInicial() {
        agregarSemanaSinGuardar("Introducción a Java y entorno de desarrollo", "Configuración de NetBeans, Tomcat y primera aplicación Java Web.", "Captura del entorno y práctica inicial.", "Completado", 100);
        agregarSemanaSinGuardar("Variables, tipos de datos y operadores", "Manejo de tipos primitivos, operadores aritméticos, lógicos y relacionales.", "Ejercicios resueltos.", "Completado", 100);
        agregarSemanaSinGuardar("Estructuras condicionales", "Uso de if, else, switch y decisions en programación.", "Programa con validaciones.", "Completado", 90);
        agregarSemanaSinGuardar("Bucles y control de flujo", "Aplicación de for, while, do while, break y continue.", "Práctica de ciclos.", "Completado", 85);
        agregarSemanaSinGuardar("Arreglos y matrices", "Organización de datos en arreglos y matrices.", "Ejercicios de arreglos.", "En proceso", 70);
        agregarSemanaSinGuardar("Métodos y funciones", "Creación de métodos reutilizables con parámetros y retorno.", "Programa modular.", "En proceso", 65);
        agregarSemanaSinGuardar("Programación orientada a objetos", "Clases, objetos, encapsulamiento, atributos y métodos.", "Modelo POO.", "Pendiente", 25);
        agregarSemanaSinGuardar("Lógica de Negocio - Compras y Planillas", "Cálculo de compras por docenas con descuentos y planilla de empleados con bonificaciones y retenciones.", "Práctica de lógica de negocio.", "Completado", 100);
        agregarSemanaSinGuardar("Lógica de Negocio - Ventas y Facturación", "Cálculo de ventas con IGV, descuentos por volumen y generación de boletas/facturas.", "Práctica de facturación.", "En proceso", 75);
        
        // Semanas adicionales por defecto de la 10 a la 14
        agregarSemanaSinGuardar("Pruebas de Software e Integración de Componentes", "Diseño y ejecución de casos de prueba funcionales para validar el sistema.", "Matriz de pruebas unitarias y reporte.", "Completado", 100);
        agregarSemanaSinGuardar("Refactorización, Limpieza de Código y Modularización", "Optimización de funciones JavaScript y hojas de estilo CSS.", "Código fuente limpio y estructurado.", "Completado", 100);
        agregarSemanaSinGuardar("Despliegue y Configuración en Entornos Cloud", "Preparación del entorno de producción y despliegue de la app web en Render.", "Enlace del proyecto operativo.", "Completado", 100);
        agregarSemanaSinGuardar("Documentación Técnica y Manual de Usuario", "Redacción de requerimientos funcionales, arquitectura y guías de administración.", "Documento final de especificaciones.", "Completado", 100);
        agregarSemanaSinGuardar("Presentación Final y Evaluación del Portafolio", "Sustentación del proyecto final, demostración de módulos CRUD y cierre.", "Entregable final del portafolio completo.", "Completado", 100);

        data.getProyectos().add(new Proyecto(data.nextProyectoId(), "Portafolio académico", "Sistema web académico con diseño rojo oscuro, panel administrador y evidencias descargables.", "Java Web / JSP", "En proceso", "◈"));
        data.getProyectos().add(new Proyecto(data.nextProyectoId(), "Dashboard administrador", "Panel privado para gestionar semanas, proyectos, archivos y perfil académico.", "JSP / Java", "En proceso", "▣"));
        data.getProyectos().add(new Proyecto(data.nextProyectoId(), "Login institucional", "Acceso moderno con correo admin@insti.edu.pe y opción de crear cuenta.", "JSP", "Finalizado", "◎"));
    }

    private void agregarSemanasFaltantes() {
        // Buscamos dinámicamente si falta alguna semana específica por su número
        if (!tieneSemana(10)) {
            agregarSemanaSinGuardar("Pruebas de Software e Integración de Componentes", "Diseño y ejecución de casos de prueba funcionales para validar el sistema.", "Matriz de pruebas unitarias y reporte.", "Completado", 100);
        }
        if (!tieneSemana(11)) {
            agregarSemanaSinGuardar("Refactorización, Limpieza de Código y Modularización", "Optimización de funciones JavaScript y hojas de estilo CSS.", "Código fuente limpio y estructurado.", "Completado", 100);
        }
        if (!tieneSemana(12)) {
            agregarSemanaSinGuardar("Despliegue y Configuración en Entornos Cloud", "Preparación del entorno de producción y despliegue de la app web en Render.", "Enlace del proyecto operativo.", "Completado", 100);
        }
        if (!tieneSemana(13)) {
            agregarSemanaSinGuardar("Documentación Técnica y Manual de Usuario", "Redacción de requerimientos funcionales, arquitectura y guías de administración.", "Documento final de especificaciones.", "Completado", 100);
        }
        if (!tieneSemana(14)) {
            agregarSemanaSinGuardar("Presentación Final y Evaluación del Portafolio", "Sustentación del proyecto final, demostración de módulos CRUD y cierre.", "Entregable final del portafolio completo.", "Completado", 100);
        }
        
        renumerarSemanas();
        guardar();
    }

    private boolean tieneSemana(int numero) {
        for (Semana s : data.getSemanas()) {
            if (s.getNumero() == numero) return true;
        }
        return false;
    }

    private void agregarSemanaSinGuardar(String tema, String descripcion, String evidencia, String estado, int progreso) {
        int numero = data.getSemanas().size() + 1;
        data.getSemanas().add(new Semana(data.nextSemanaId(), numero, tema, descripcion, evidencia, estado, progreso));
    }

    public synchronized List<Semana> getSemanas() {
        ordenarSemanas();
        return new ArrayList<>(data.getSemanas());
    }

    public synchronized List<Proyecto> getProyectos() { return new ArrayList<>(data.getProyectos()); }
    public synchronized SobreMi getSobreMi() { return data.getSobreMi(); }

    public synchronized int getTotalArchivos() {
        int total = 0;
        for (Semana s : data.getSemanas()) total += s.getArchivos().size();
        for (Proyecto p : data.getProyectos()) total += p.getArchivos().size();
        total += data.getSobreMi().getArchivos().size();
        return total;
    }

    public synchronized void agregarSemana(String tema, String descripcion, String evidencia, String estado, int progreso) {
        agregarSemanaSinGuardar(tema, descripcion, evidencia, estado, progreso);
        guardar();
    }

    public synchronized void eliminarSemana(int id) {
        data.getSemanas().removeIf(s -> s.getId() == id);
        renumerarSemanas();
        guardar();
    }

    public synchronized void moverSemana(int id, String direccion) {
        ordenarSemanas();
        List<Semana> semanas = data.getSemanas();

        for (int i = 0; i < semanas.size(); i++) {
            if (semanas.get(i).getId() == id) {
                if ("up".equals(direccion) && i > 0) {
                    int n = semanas.get(i).getNumero();
                    semanas.get(i).setNumero(semanas.get(i - 1).getNumero());
                    semanas.get(i - 1).setNumero(n);
                } else if ("down".equals(direccion) && i < semanas.size() - 1) {
                    int n = semanas.get(i).getNumero();
                    semanas.get(i).setNumero(semanas.get(i + 1).getNumero());
                    semanas.get(i + 1).setNumero(n);
                }
                break;
            }
        }

        renumerarSemanas();
        guardar();
    }

    public synchronized void agregarProyecto(String titulo, String descripcion, String tecnologia, String estado, String icono) {
        if (icono == null || icono.trim().isEmpty()) icono = "◈";
        data.getProyectos().add(new Proyecto(data.nextProyectoId(), titulo, descripcion, tecnologia, estado, icono));
        guardar();
    }

    public synchronized void eliminarProyecto(int id) {
        data.getProyectos().removeIf(p -> p.getId() == id);
        guardar();
    }

    public synchronized void actualizarSobreMi(String titulo, String descripcion, String intereses) {
        SobreMi s = data.getSobreMi();
        s.setTitulo(titulo);
        s.setDescripcion(descripcion);
        s.setIntereses(intereses);
        guardar();
    }

    public synchronized void guardarArchivoSemana(int semanaId, String nombre, String tipo, String base64) throws Exception {
        Semana s = buscarSemana(semanaId);
        if (s == null) return;
        Archivo a = guardarBase64(nombre, tipo, base64);
        if (a != null) {
            s.getArchivos().add(a);
            guardar();
        }
    }

    public synchronized void guardarArchivoProyecto(int proyectoId, String nombre, String tipo, String base64) throws Exception {
        Proyecto p = buscarProyecto(proyectoId);
        if (p == null) return;
        Archivo a = guardarBase64(nombre, tipo, base64);
        if (a != null) {
            p.getArchivos().add(a);
            guardar();
        }
    }

    public synchronized void guardarArchivoSobreMi(String nombre, String tipo, String base64) throws Exception {
        Archivo a = guardarBase64(nombre, tipo, base64);
        if (a != null) {
            data.getSobreMi().getArchivos().add(a);
            guardar();
        }
    }

    private Archivo guardarBase64(String nombre, String tipo, String base64) throws Exception {
        if (base64 == null || base64.trim().isEmpty()) return null;

        if (nombre == null || nombre.trim().isEmpty()) nombre = "archivo";
        nombre = nombre.replaceAll("[^a-zA-Z0-9._-]", "_");

        int coma = base64.indexOf(",");
        if (coma >= 0) base64 = base64.substring(coma + 1);

        byte[] bytes = Base64.getDecoder().decode(base64);
        int id = data.nextArchivoId();

        File destino = new File(uploadsDir, id + "_" + nombre);
        Files.write(destino.toPath(), bytes);

        return new Archivo(id, nombre, destino.getAbsolutePath(), tipo, bytes.length);
    }

    public synchronized Archivo buscarArchivo(int id) {
        for (Semana s : data.getSemanas()) for (Archivo a : s.getArchivos()) if (a.getId() == id) return a;
        for (Proyecto p : data.getProyectos()) for (Archivo a : p.getArchivos()) if (a.getId() == id) return a;
        for (Archivo a : data.getSobreMi().getArchivos()) if (a.getId() == id) return a;
        return null;
    }

    public synchronized void eliminarArchivo(int id) {
        Archivo archivo = buscarArchivo(id);
        if (archivo != null) {
            try { new File(archivo.getRutaGuardada()).delete(); } catch (Exception ignored) {}
        }

        for (Semana s : data.getSemanas()) s.getArchivos().removeIf(a -> a.getId() == id);
        for (Proyecto p : data.getProyectos()) p.getArchivos().removeIf(a -> a.getId() == id);
        data.getSobreMi().getArchivos().removeIf(a -> a.getId() == id);
        guardar();
    }

    private Semana buscarSemana(int id) {
        for (Semana s : data.getSemanas()) if (s.getId() == id) return s;
        return null;
    }

    private Proyecto buscarProyecto(int id) {
        for (Proyecto p : data.getProyectos()) if (p.getId() == id) return p;
        return null;
    }

    private void ordenarSemanas() {
        data.getSemanas().sort(Comparator.comparingInt(Semana::getNumero));
    }

    private void renumerarSemanas() {
        ordenarSemanas();
        int i = 1;
        for (Semana s : data.getSemanas()) s.setNumero(i++);
    }
}