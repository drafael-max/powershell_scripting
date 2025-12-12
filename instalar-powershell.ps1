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

#*****************************************************************************
#TERCER SCRIPT: INTERFAZ GRAFICA DE USUARIO 
#NOMBRE Y APELLIDO DEL AUTOR: JOSE FUEL 
#FECHA: 12 DE DICIEMBRE DEL 2025

# Carga de librerías necesarias para crear interfaces gráficas

# Agrega la librería necesaria para usar ventanas, botones, cuadros de texto, etc.
Add-Type -AssemblyName System.Windows.Forms

# Agrega la librería necesaria para manejar configuraciones de tamaño y gráficos.
Add-Type -AssemblyName System.Drawing


# Creación de la ventana principal del formulario

# Crea un nuevo formulario (ventana)
$form = New-Object System.Windows.Forms.Form

# Título que aparecerá en la parte superior de la ventana
$form.Text = "Input Form"

# Tamaño de la ventana: ancho 500, alto 250
$form.Size = New-Object System.Drawing.Size(500,250)

# Hace que la ventana aparezca centrada en la pantalla
$form.StartPosition = "CenterScreen"


# Creación de los labels (textos que guían al usuario)

# Primer label: "Input 1"
$textLabel1 = New-Object System.Windows.Forms.Label
$textLabel1.Text = "Input 1:"       # Texto que muestra
$textLabel1.Left = 20               # Posición en el eje X
$textLabel1.Top = 20                # Posición en el eje Y
$textLabel1.Width = 120             # Ancho del label

# Segundo label: "Input 2"
$textLabel2 = New-Object System.Windows.Forms.Label
$textLabel2.Text = "Input 2:"
$textLabel2.Left = 20
$textLabel2.Top = 60
$textLabel2.Width = 120

# Tercer label: "Input 3"
$textLabel3 = New-Object System.Windows.Forms.Label
$textLabel3.Text = "Input 3:"
$textLabel3.Left = 20
$textLabel3.Top = 100
$textLabel3.Width = 120


# Cuadros de texto donde el usuario ingresa valores

# Caja de texto 1
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Left = 150
$textBox1.Top = 20
$textBox1.Width = 200

# Caja de texto 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Left = 150
$textBox2.Top = 60
$textBox2.Width = 200

# Caja de texto 3
$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Left = 150
$textBox3.Top = 100
$textBox3.Width = 200

# Asignamos un valor por defecto (vacío)
$defaultValue = ""
$textBox1.Text = $defaultValue
$textBox2.Text = $defaultValue
$textBox3.Text = $defaultValue


# Botón "OK" para finalizar y capturar los valores

$button = New-Object System.Windows.Forms.Button
$button.Left = 360         # Posición X
$button.Top = 140          # Posición Y
$button.Width = 100        # Ancho del botón
$button.Text = "OK"        # Texto del botón

# Evento que ocurre cuando el usuario hace clic en el botón
$button.Add_Click({

    # Guardamos los valores ingresados por el usuario dentro de la propiedad Tag del formulario
    $form.Tag = @{
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }

    # Cierra la ventana después de guardar los datos
    $form.Close()
})


# Añadir todos los elementos a la ventana

$form.Controls.Add($button)
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textBox1)
$form.Controls.Add($textBox2)
$form.Controls.Add($textBox3)


# Mostrar la ventana al usuario

$form.ShowDialog() | Out-Null


# Devolver los valores ingresados (output del script)

return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3
