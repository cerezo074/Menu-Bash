
#Import Scripts

. generalscommands.sh
. someusers.sh
. filesystem.sh

#MAIN PROGRAM

echo "Bienvenido"

while [ : ]
do

 echo "
Menu principal

Selecciona una de las siguientes opciones: 

1. Comandos Generales
2. Varios Usuarios
3. Sistema de archivo
9. Salir
"

 read -p "Ingresa la opcion: " option

 case $option in
  1) generalsCommands ;;
  2) someUsers ;;
  3) fileSystem ;;
  9) break;;
  *) echo "Opcion no valida!"
 esac

done

echo "
Buen dia!!
"
