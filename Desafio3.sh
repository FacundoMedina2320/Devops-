#!/bin/bash

# Grupos y usuarios
GRUPOS=("Desarrollo" "Operaciones" "Ingeniería")
USUARIOS=("usuario1" "usuario2" "usuario3" "usuario4" "usuario5" "usuario6")
CONTRASENA="ContraseñaSegura123"

# Crear grupos si no existen
for GRUPO in "${GRUPOS[@]}"; do
    if ! getent group "$GRUPO" &>/dev/null; then
        groupadd "$GRUPO"
    fi
done

# Crear usuarios y asignar contraseñas
for USUARIO in "${USUARIOS[@]}"; do
    if ! id -u "$USUARIO" &>/dev/null; then
        useradd -m "$USUARIO"
        echo "$USUARIO:$CONTRASENA" | chpasswd
    fi
done

# Asignar usuarios a los grupos
usermod -aG Desarrollo usuario1
usermod -aG Desarrollo usuario2
usermod -aG Operaciones usuario3
usermod -aG Operaciones usuario4
usermod -aG Ingeniería usuario5
usermod -aG Ingeniería usuario6

# Crear carpetas y asignar permisos
for USUARIO in "${USUARIOS[@]}"; do
    mkdir -p "/home/$USUARIO"
    chown -R "$USUARIO:$USUARIO" "/home/$USUARIO"
    chmod 700 "/home/$USUARIO"
done

echo "Proceso completado."
