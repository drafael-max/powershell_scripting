#PRIMER SCRIPT: INSTALAR POWERSHELL EN CODESPACE
#NOMBRE Y APELLIDO DEL AUTOR: RAFAEL PATIN
#FECHA: 12 DE DICIEMBRE DEL 2025

# Actualizar lista de paquetes
sudo apt-get update -y

# Instalar dependencias necesarias
sudo apt-get install -y wget apt-transport-https software-properties-common

# Detectar versión de Ubuntu
source /etc/os-release
echo "Ubuntu detectado: $VERSION_ID"

# Descargar paquete de repositorio Microsoft
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Instalar el paquete .deb
sudo dpkg -i packages-microsoft-prod.deb

# Limpiar archivo temporal
rm packages-microsoft-prod.deb

# Actualizar con el nuevo repositorio
sudo apt-get update -y

# Instalar PowerShell
sudo apt-get install -y powershell

# Mensaje
echo ""
echo "Powershell instalado correctamente"
echo "Ejecuta: pwsh"
