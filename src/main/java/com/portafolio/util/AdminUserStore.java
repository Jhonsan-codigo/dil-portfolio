package com.portafolio.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

public class AdminUserStore {
    private static final AdminUserStore INSTANCE = new AdminUserStore();

    private final File dataDir;
    private final File usersFile;
    private final Properties users;

    private AdminUserStore() {
        dataDir = new File(System.getProperty("user.home"), "PortafolioJSPData");
        usersFile = new File(dataDir, "usuarios.properties");
        users = new Properties();
        cargar();
    }

    public static AdminUserStore getInstance() { return INSTANCE; }

    private synchronized void cargar() {
        try {
            if (!dataDir.exists()) dataDir.mkdirs();
            if (usersFile.exists()) {
                try (FileInputStream in = new FileInputStream(usersFile)) {
                    users.load(in);
                }
            }
            if (!users.containsKey("admin@insti.edu.pe")) {
                users.setProperty("admin@insti.edu.pe", "admin123");
                guardar();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private synchronized void guardar() {
        try {
            if (!dataDir.exists()) dataDir.mkdirs();
            try (FileOutputStream out = new FileOutputStream(usersFile)) {
                users.store(out, "Usuarios administrador");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public synchronized boolean registrar(String correo, String clave) {
        if (correo == null || clave == null) return false;
        correo = correo.toLowerCase().trim();
        if (!correo.endsWith("@insti.edu.pe")) return false;
        users.setProperty(correo, clave);
        guardar();
        return true;
    }

    public synchronized boolean validar(String correo, String clave) {
        if (correo == null || clave == null) return false;
        correo = correo.toLowerCase().trim();
        return clave.equals(users.getProperty(correo));
    }
}
