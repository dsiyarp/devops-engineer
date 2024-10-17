#!/bin/bash

# Detección de la distribución Linux
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "No se puede detectar la distribución de Linux."
    exit 1
fi

# Identificación del gestor de paquetes
case "$DISTRO" in
    ubuntu|debian)
        PACKAGE_MANAGER="apt"
        UPDATE_CMD="apt update"
        UPGRADE_CMD="apt upgrade -y"
        INSTALL_CMD="apt install -y"
        ;;
    fedora)
        PACKAGE_MANAGER="dnf"
        UPDATE_CMD="dnf check-update"
        UPGRADE_CMD="dnf upgrade -y"
        INSTALL_CMD="dnf install -y"
        ;;
    centos)
        PACKAGE_MANAGER="yum"
        UPDATE_CMD="yum check-update"
        UPGRADE_CMD="yum upgrade -y"
        INSTALL_CMD="yum install -y"
        ;;
    arch)
        PACKAGE_MANAGER="pacman"
        UPDATE_CMD="pacman -Sy"
        UPGRADE_CMD="pacman -Syu --noconfirm"
        INSTALL_CMD="pacman -S --noconfirm"
        ;;
    *)
        echo "Distribución no soportada: $DISTRO"
        exit 1
        ;;
esac

# Actualizar e instalar actualizaciones del sistema
echo "Actualizando la lista de paquetes..."
$UPDATE_CMD

echo "Actualizando el sistema..."
$UPGRADE_CMD

# Instalar el servidor Apache
echo "Instalando el servidor web Apache..."
$INSTALL_CMD apache2

# Verificar que Apache se haya instalado correctamente
if ! command -v apache2 &> /dev/null; then
    echo "La instalación de Apache ha fallado."
    exit 1
fi

# Modificar el archivo index.html
echo "Personalizando el archivo index.html..."
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>Bootcamp DevOps</title>
</head>
<body>
<h1>Bootcamp DevOps Engineer</h1>
</body>
</html>" > /var/www/html/index.html

# Reiniciar Apache para aplicar los cambios
echo "Reiniciando el servicio Apache..."
systemctl restart apache2

echo "¡Instalación completada con éxito!"
