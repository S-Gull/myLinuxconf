#!/bin/bash
# Instalador completo para múltiples aplicaciones
# Requiere sudo y conexión a internet

# Verificar root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecutar con sudo"
    exit 1
fi

# Actualizar sistema
echo "Actualizando sistema..."
apt update -qq && apt upgrade -y -qq

# Instalar dependencias comunes
echo "Instalando dependencias..."
apt install -y -qq wget curl software-properties-common apt-transport-https

# Función para añadir repositorios
add_repo() {
    echo "Añadiendo repositorio: $1"
    add-apt-repository -y $1 > /dev/null 2>&1
}

# 1. Instalar Mainline Kernel
echo "🖥️ Instalando Mainline Kernel..."
add_repo ppa:cappelikan/ppa
apt update -qq
apt install -y -qq mainline

# 2. Instalar Opera
echo "🌐 Instalando Opera..."
wget -qO- https://deb.opera.com/archive.key | gpg --dearmor | tee /usr/share/keyrings/opera.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/opera.gpg] https://deb.opera.com/opera-stable/ stable non-free" | tee /etc/apt/sources.list.d/opera.list
apt update -qq
apt install -y -qq opera-stable

# 3. Instalar Discord
echo "🎮 Instalando Discord..."
wget -qO discord.deb "https://discord.com/api/download?platform=linux&format=deb"
dpkg -i discord.deb > /dev/null 2>&1
apt install -f -y -qq
rm discord.deb

# 4. Instalar Visual Studio Code
echo "💻 Instalando VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list
apt update -qq
apt install -y -qq code

# 5. Instalar Telegram
echo "📨 Instalando Telegram..."
snap install telegram-desktop -y
# wget -qO- https://telegram.org/dl/desktop/linux | tar xJ -C /opt/
# mv /opt/Telegram*/ /opt/telegram
# ln -sf /opt/telegram/Telegram /usr/local/bin/telegram
# cat > /usr/share/applications/telegram.desktop <<EOL
# [Desktop Entry]
# Version=1.0
# Name=Telegram
# Exec=/opt/telegram/Telegram
# Icon=/opt/telegram/telegram.png
# Terminal=false
# Type=Application
# Categories=Network;InstantMessaging;
# EOL

# 6. Instalar Spotify
echo "🎵 Instalando Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor | tee /usr/share/keyrings/spotify.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt update -qq
apt install -y -qq spotify-client

# 7. Instalar Microsoft Edge
echo "🔵 Instalando Microsoft Edge..."
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-edge.gpg
echo "deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list
apt update -qq
apt install -y -qq microsoft-edge-stable

# Limpiar
echo "🧹 Limpiando..."
apt autoremove -y -qq
apt clean -qq

echo "✅ Instalación completada!"