#!/bin/bash

# Instalador de Firefox Developer Edition
# Requiere conexión a internet y permisos de sudo

# Configuración
DOWNLOAD_URL="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=es-ES"
INSTALL_DIR="/opt/firefox_dev"
DESKTOP_FILE="/usr/share/applications/firefox-dev.desktop"
BIN_LINK="/usr/local/bin/firefox-dev"

# Verificar si es root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse con sudo"
    exit 1
fi

# Actualizar repositorios
echo "Actualizando lista de paquetes..."
apt-get update -qq

# Instalar dependencias recomendadas
echo "Instalando dependencias..."
apt-get install -y -qq wget libgtk-3-0 dbus-x11

# Descargar Firefox Developer Edition
echo "Descargando Firefox Developer Edition..."
wget -q --show-progress -O firefox-dev.tar.bz2 "$DOWNLOAD_URL"

# Verificar descarga
if [ ! -f firefox-dev.tar.bz2 ]; then
    echo "Error al descargar el archivo"
    exit 1
fi

# Eliminar instalaciones previas
echo "Preparando instalación..."
rm -rf "$INSTALL_DIR" 2> /dev/null

# Extraer archivos
echo "Instalando en $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
tar xjf firefox-dev.tar.bz2 -C "$INSTALL_DIR" --strip-components=1
chmod 755 "$INSTALL_DIR"

# Crear enlace simbólico
echo "Creando acceso global..."
ln -sf "$INSTALL_DIR/firefox" "$BIN_LINK"

# Crear acceso directo
echo "Creando acceso directo..."
cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Version=1.0
Name=Firefox Developer Edition
GenericName=Web Browser
Exec=$INSTALL_DIR/firefox %u
Icon=$INSTALL_DIR/browser/chrome/icons/default/default128.png
#Icon=firefox-developer-edition
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;
StartupWMClass=firefox-aurora
EOL

# Limpiar archivos temporales
echo "Limpiando..."
rm firefox-dev.tar.bz2

# Actualizar base de datos de íconos
update-desktop-database -q

echo "¡Instalación completa!"
echo "Puedes ejecutar Firefox Developer Edition con: firefox-dev"