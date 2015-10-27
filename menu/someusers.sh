
sendMessageToUser(){

userExist
if [ $? -eq 0 ]
then
 echo "
Ingresa el mensage, presiona enter para enviar cuando quieras salir presiona 'ctrl d' para terminar."
 write $user
 echo "Mensaje terminado"
else
 echo "Lo sentimos no se puede enviar el mensaje a $user"
fi

}

userExist(){

read -p "Ingresa el usuario a buscar: " user

if [ "$user" != "" ] 
then

 exist=0
 
 for u in $(who | cut -d' ' -f1 | sort | uniq)
 do
 
  if [ "$u" == "$user" ]
  then
   exist=1
   break  
  fi
 done
 
 if [ $exist -eq 1 ]
 then
  echo "el ususario $user existe!"
  return 0
 else
  echo "el usuario $user no existe"
  return 1
 fi

else
 echo "Usuario invalido!!"
 return 1
fi

}

showAmoutUsersConnected(){

num=$(who -q | tail -1 | sed 's/.*=//') 
echo "El numero de usuarios conectados es: $(($num-1))" 

}

showUsersLogged(){

users=$(who | cut -d' ' -f1 | sort | uniq)
echo "Los usuarios registrados en el sistema son:
$users"

}

someUsers(){

echo "
Varios Usuarios

Selecciona las siguientes opciones:

1. Mostrar nombre de usuarios conectados
2. Mostrar numero de usuarios conectados
3. Averiguar si un usuario esta conectado
4. Enviar mensaje a un usuario
9. Regresar
"

while [ : ]
do 

 read -p "Ingresa la opcion: " option
 
 case $option in
  1) showUsersLogged;;
  2) showAmoutUsersConnected;;
  3) userExist;;
  4) sendMessageToUser;;
  9) break;;
  *) echo "Opcion no valida!"
 esac

done

}
