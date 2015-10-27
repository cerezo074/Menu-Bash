
getTime(){

time=$(date +"%T")
echo "La hora es: $time"

}

getCurrentPath(){

path=$(pwd)
echo "Tu estas en: $path"

}

showFreeSpace(){

freespace=$(df -kh /tmp | tail -1 | awk '{print $4}')
echo "Tienes $freespace libres"

}

generalsCommands(){

echo "
Comandos Generales

Selecciona las siguientes opciones:

1. Vizualizar hora del sistema
2. Path o ruta actual
3. Cambio de Password
4. Mostrar disco libre
5. Visualizar procesos activos
6. Visualizar Estructura del path actual
9. Regresar
"

while [ : ]
do

read -p "Ingresa la opcion: " option

  case $option in
   1) getTime;;
   2) getCurrentPath;;
   3) passwd;;
   4) showFreeSpace;;
   5) ps aux;;
   6) ls -al;;
   9) break;;
   *) echo "Opcion no valida!"
  esac

done

}
