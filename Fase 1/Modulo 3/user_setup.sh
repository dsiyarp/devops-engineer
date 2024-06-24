#!/bin/bash

# Función para registrar en syslog
log_action() {
    local message=$1
    logger -t user_setup_script "$message"
}

# Función para generar contraseñas seguras
generate_password() {
    tr -dc A-Za-z0-9_@#%&*+=- < /dev/urandom | head -c 16
}

# Crear grupos
groups=("Desarrollo" "Operaciones" "Ingeniería")
for group in "${groups[@]}"; do
    groupadd $group
    log_action "Grupo creado: $group"
done

# Crear usuarios y asignar grupos
declare -A users
users=( ["usuario1"]="Desarrollo" ["usuario2"]="Desarrollo"
        ["usuario3"]="Operaciones" ["usuario4"]="Operaciones"
        ["usuario5"]="Ingeniería" ["usuario6"]="Ingeniería" )

for user in "${!users[@]}"; do
    group=${users[$user]}
    password=$(generate_password)
    useradd -m -G $group -s /bin/bash $user
    echo "$user:$password" | chpasswd
    log_action "Usuario creado: $user, asignado al grupo: $group"
    log_action "Contraseña asignada para $user: $password"
done

# Crear carpetas específicas y modificar ownership
for user in "${!users[@]}"; do
    user_home="/home/$user"
    user_folder="$user_home/${user}_folder"
    mkdir -p $user_folder
    chown $user:$user $user_folder
    log_action "Carpeta creada para $user en $user_folder con ownership modificado"
done

# Configurar permisos (Ejemplo: lectura, escritura y ejecución para el usuario, lectura para el grupo, sin permisos para otros)
for user in "${!users[@]}"; do
    user_home="/home/$user"
    user_folder="$user_home/${user}_folder"
    chmod 750 $user_folder
    log_action "Permisos configurados en $user_folder para $user"
done

echo "Script ejecutado con éxito. Revisa /var/log/syslog para detalles."
