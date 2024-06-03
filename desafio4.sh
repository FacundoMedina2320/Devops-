#!/bin/bash
#Facundo Medina 
#Identifica  Informacion de sistema 
echo  "INFORMACION DE SISTEMAS"
cat /etc/os-release |  grep NAME=

#Identifica gestor de paquetes 
echo "Identificar gestor de paquetes"

if [[ $DISTRO == *"ubuntu"* ]] || [[ $DISTRO == *"debian"* ]]; then
    PACKAGE_MANAGER="apt"
elif [[ $DISTRO == *"fedora"* ]]; then
    PACKAGE_MANAGER="dnf"
elif [[ $DISTRO == *"centos"* ]]; then
    PACKAGE_MANAGER="yum"
else
    PACKAGE_MANAGER="pacman" # Para Arch Linux
fi
 

echo "El gestor de paquetes es: $PACKAGE_MANAGER"
echo "Actualizando la lista de paquetes disponibles..."
 
#Actualiacion de sistema 
#Sacar el -y si desea que no le pida pirmiso para instalar 

apt update -y

if [ $? -ne 0 ]; then

    echo "Error: Falló la actualización de la lista de  paquetes."
	echo "Ejecutar como administrador"	
    exit 1

fi

 apt upgrade -y

if [ $? -ne 0 ]; then

    echo "Error: Falló la actualización de la lista de  paquetes."

    exit 1

fi


#Instalar Apache 

sudo apt install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
#sudo systemctl enable apache2 (Habilita Apache para que inicie al arrancar el sistema)
sudo systemctl status apache2 #Verificar el estado del servicio de Apache:

#Modofica el archivo index.html
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootcamp DevOps</title>
</head>
<body>
    <h1>Bootcamp DevOps Engineer</h1>
	<h2>Facundo Medina</h2>
    <img src="https://images3.memedroid.com/images/UPLOADED120/6628d42c5587f.jpeg" alt="Meme">
</body>
</html>' > index.html

# Mover el archivo index.html al directorio de Apache
sudo mv index.html /var/www/html/index.html

# Verificar el estado de Apache
sudo systemctl status apache2
#facundo Medina 
