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

#*****************************************************************************
#SEGUNDO SCRIPT: CREAR BARRA DE PROGRESO 
#NOMBRE Y APELLIDO DEL AUTOR: CRISTOPHER VENEGAS
#FECHA: 12 DE DICIEMBRE DEL 2025

# Define la función Start-ProgressBar
function Start-ProgressBar {
    # Habilita características avanzadas de cmdlets
    [CmdletBinding()]
    # Declaración de parámetros
    param (
        # Parámetro obligatorio: título de la barra de progreso 
        [Parameter(Mandatory = $true)]
        $Title,

        # Parámetro obligatorio: tiempo en segundos
        [Parameter(Mandatory = $true)]
        [int]$Timer
    )

    # Ciclo que avanza desde 1 hasta el valor de Timer
    for ($i = 1; $i -le $Timer; $i++) {
        # Espera 1 segundo por cada iteración
        Start-Sleep -Seconds 1

        # Calcula el porcentaje completado
        $percentComplete = ($i / $Timer) * 100

        # Muestra y actualiza la barra de progreso
        Write-Progress -Activity $Title -Status "$i seconds elapsed" -PercentComplete $percentComplete
    }
}

# Ejecuta la funcion con un totulo y duración de 30 segundos
Start-ProgressBar -Title "Test timeout" -Timer 30