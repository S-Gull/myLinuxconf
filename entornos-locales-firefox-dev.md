
# Documentación: Configuración de Entornos Locales y Firefox Developer Edition en Ubuntu 24.04

## Tabla de Contenidos
1. [Requisitos Previos](#requisitos-previos)
2. [Configuración de Entornos Locales](#configuración-de-entornos-locales)
   - [Entorno Personal](#entorno-personal)
   - [Entorno Profesional](#entorno-profesional)
3. [Instalación de Firefox Developer Edition](#instalación-de-firefox-developer-edition)
4. [Notas para el Uso de Opera](#notas-para-el-uso-de-opera)

---

## Requisitos Previos
Antes de comenzar, asegúrate de tener:
- Ubuntu 24.04 LTS instalado.
- Permisos de administrador para instalar y configurar servicios.
- Un editor de texto como `nano` o `vim`.

---

## Configuración de Entornos Locales

### Entorno Personal
Este entorno está diseñado para clases de programación y proyectos personales, usando PHP, JavaScript y SQLite.

1. **Instalar Apache, PHP y SQLite**:
   ```bash
   sudo apt update
   sudo apt install apache2 php libapache2-mod-php sqlite3 php-sqlite3
   ```

2. **Crear el VirtualHost**:
   ```bash
   sudo nano /etc/apache2/sites-available/personal.local.conf
   ```
   Contenido del archivo:
   ```apache
   <VirtualHost *:80>
       ServerName personal.local
       DocumentRoot /var/www/personal
       <Directory /var/www/personal>
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   ```

3. **Habilitar el VirtualHost y agregar al archivo `/etc/hosts`**:
   ```bash
   sudo a2ensite personal.local.conf
   echo "127.0.0.1 personal.local" | sudo tee -a /etc/hosts
   sudo systemctl reload apache2
   ```

4. **Crear el directorio del proyecto**:
   ```bash
   sudo mkdir -p /var/www/personal
   sudo chown -R $USER:$USER /var/www/personal
   echo "<?php phpinfo(); ?>" > /var/www/personal/index.php
   ```

Accede a tu entorno en `http://personal.local`.

---

### Entorno Profesional
Este entorno está configurado para trabajar con Vue, Laravel y PostgreSQL.

1. **Instalar Apache, PHP, Composer y PostgreSQL**:
   ```bash
   sudo apt update
   sudo apt install apache2 php libapache2-mod-php composer postgresql php-pgsql
   ```

2. **Crear el VirtualHost**:
   ```bash
   sudo nano /etc/apache2/sites-available/profesional.local.conf
   ```
   Contenido del archivo:
   ```apache
   <VirtualHost *:80>
       ServerName profesional.local
       DocumentRoot /var/www/profesional/public
       <Directory /var/www/profesional/public>
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   ```

3. **Habilitar el VirtualHost y agregar al archivo `/etc/hosts`**:
   ```bash
   sudo a2ensite profesional.local.conf
   echo "127.0.0.1 profesional.local" | sudo tee -a /etc/hosts
   sudo systemctl reload apache2
   ```

4. **Configurar Laravel**:
   - Instala Laravel en el directorio `/var/www/profesional` con Composer:
     ```bash
     composer create-project --prefer-dist laravel/laravel /var/www/profesional
     ```
   - Asegúrate de configurar correctamente las credenciales de PostgreSQL en el archivo `.env`.

Accede a tu entorno en `http://profesional.local`.

---

## Instalación de Firefox Developer Edition

### Pasos:
1. **Descargar y extraer Firefox Developer Edition**:
   ```bash
   wget -O firefox-dev.tar.bz2 https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US
   tar xjf firefox-dev.tar.bz2
   sudo mv firefox /opt/firefox-developer
   ```

2. **Crear enlace simbólico**:
   ```bash
   sudo ln -s /opt/firefox-developer/firefox /usr/local/bin/firefox-developer
   ```

3. **Crear un archivo de escritorio**:
   ```bash
   sudo nano /usr/share/applications/firefox-developer.desktop
   ```
   Contenido del archivo:
   ```plaintext
   [Desktop Entry]
   Name=Firefox Developer Edition
   Exec=/usr/local/bin/firefox-developer
   Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png
   Type=Application
   Categories=Development;WebBrowser;
   ```

4. **Actualizar accesos de escritorio**:
   ```bash
   sudo update-desktop-database
   ```

Ahora puedes ejecutar Firefox Developer Edition desde el lanzador o la terminal con `firefox-developer`.

---

## Notas para el Uso de Opera

1. **Deshabilitar VPN de Opera**:
   - Ve a **Configuración → Privacidad y Seguridad → VPN** y asegúrate de que esté desactivada.

2. **Habilitar resolución de dominios locales**:
   - Desactiva la opción **"DNS-over-HTTPS"** en **Configuración → Privacidad y Seguridad → Sistema**.

3. **Asegurarte de incluir el prefijo `http://` al acceder a dominios locales.**

Si experimentas problemas con entornos locales en Opera, intenta deshabilitar la aceleración de hardware en **Configuración → Avanzado → Sistema**.

---

## Créditos
Esta guía fue creada en colaboración con ChatGPT y documenta el proceso de configuración realizado en Ubuntu 24.04 LTS.
