
deleteDirectory(){

read -p "Ingresa el nombre del directorio a eliminar: " sourcepath

if [ -d "$sourcepath" ]
then
 
 rm -rf $sourcepath
 
 if [ $? -eq 0 ]
 then
  echo "Directorio borrado"
 else
  echo "Error borrando el directorio"
 fi
 
else
echo "Error, quizas el directorio no existe o es un nombre invalido"
fi

}

renameFile(){

read -p "Ingresa el nombre del archivo a renombrar: " sourcepath

if [ -e "$sourcepath" ]
then

read -p "Ingresa el nuevo nombre para el archivo: " newname
regex="[a-zA-Z0-9]+\.{1}[a-zA-Z]"

 if [ "$newname" != "" ] && [[ "$newname" =~ $regex ]] && [ ! -e $newname ]
 then 
 
  mv $sourcepath $newname
 
  if [ $? -eq 0 ]
  then
   echo "Archivo renombrado"
  else
   echo "Error renombrando el archivo"
  fi 

 else
  echo "Error el nombre del nuevo archivo no es valido por favor verificalo"
 fi

else
echo "Error, quizas el archivo no existe o es un directorio"
fi

}

deleteFile(){

read -p "Ingresa el nombre del archivo a eliminar: " sourcepath

if [ -e "$sourcepath" ]
then
 
 rm -rf $sourcepath
 
 if [ $? -eq 0 ]
 then
  echo "Archivo borrado"
 else
  echo "Error borrando el archivo"
 fi
 
else
echo "Error, quizas el archivo no existe o es un directorio"
fi

}

readFile(){

read -p "Ingresa el nombre del archivo a leer: " sourcepath

if [ -r "$sourcepath" ]
then
 cat $sourcepath
else
 echo "Error el archivo puede que no exista o no tengas permisos para leerlo"
fi

}

copyFile(){

read -p "Ingresa el nombre del archivo a copiar: " sourcepath

if [ "$sourcepath" == "" ] || [ ! -f "$sourcepath" ]
then
 echo "Error el archivo puede que no exista o es un directorio!"
else

 read -p "la ruta donde quieres hacer la copia: " targetpath

 if [ "$targetpath" != "" ] && [ $targetpath != $sourcepath ]
 then

  regex="[a-zA-Z0-9]+\.{1}[a-zA-Z]"

  if [ -d $targetpath ] || [[  "$targetpath" =~ $regex ]] || [ $targetpath == ".." ] && [ ! -f $targetpath ]
  then
   cp $sourcepath $targetpath

   if [ $? -eq 0 ]
   then
    echo "Archivo copiado"
   else
    echo "Error copiando el archivo"
   fi 

  else
   echo "Error, solo se aceptan '..' o 'directorio exitente' o 'nombrearchivi.extension' o quizas el archivo ya existe"
  fi       

 else
  echo "Error, puede que ruta destino no exista o el nombre es invalido"
 fi

fi 

}

changePermissonsOnFile(){

sourcepath="Concurrencia.docx"
#read -p "Ingresa el nombre del archivo para modificar los permisos: " sourcepath

if [ ! -f "$sourcepath" ]
then
 echo "Error, nombre de archivo invalido"
 return 1
fi

echo "
Para cambiar los permisos de sobre un archivo deberas pasar 3 numeros entre el 0-7.

0. no hay permisos(lectura, escritura y ejecucion)
1. solo permisos de ejecucion  
2. solo permisos de escritura
3. permisos de escritura y de ejecucion
4. permisos de lectura unicamente
5. permisos de lectura y ejecucion
6. permisos de lectura y escritura
7. todos los permisos(lectura, escritura y ejecucion)

El primer digito concede permisos al propietario del archivo, segundo a el grupo y el tercero a otros individuos que no pertenecen al grupo del propietario.
"
read -p "Ingresa el digito para los permisos del propietario: " owner
read -p "Ingresa el digito para los permisos del grupo: " group
read -p "Ingresa el digito para los permisos para otros: " others

regex="[[:alpha:]]|[[:punct:]]"
valid=1

#validate if the input is different to a number

if [ "$owner" == "" ] || [[ "$owner" =~ $regex ]] || [ $(($owner)) -lt 0 ] || [ $(($owner)) -gt 7 ]
then
valid=0
fi

if [ "$group" == "" ] || [[ "$group" =~ $regex ]] || [ $(($group)) -lt 0 ] || [ $(($group)) -gt 7 ]
then
valid=0
fi

if [ "$others" == "" ] || [[ "$others" =~ $regex ]] ||  [ $(($others)) -lt 0 ] || [ $(($others)) -gt 7 ]
then
valid=0
fi

if [ $valid -eq 1 ]
then

 permissons="$owner$group$others"
 echo "chmod $permissons $sourcepath"
 chmod $permissons $sourcepath 

 if [ $? -eq 0 ]
 then
  echo "Permisos modificados"
 else
  echo "Error modificando permisos, codigo de error:$?"
 fi

else
echo "Numero incorrecto, algun numero sumistrado es incorrecto, por favor vuelve a verificar"
fi

}

createDirectory(){

read -p "Ingresa el nombre del directorio a crear: " path

if [ "$path" == "" ] || [ -d "$path" ]
then
 echo "El directorio ya existe o el nombre es invalido!"
else

 mkdir $path

 if [ $? -eq 0 ]
 then
  echo "Directorio creado en: $path"
 else
  echo "Error creando directorio"
 fi 

fi 

}

fileSystem(){

echo "
Sistema de Archivo

Selecciona las siguientes opciones:

1. Crear directorio
2. Copiar archivo
3. Modificar Permisos a un archivo
4. Visualizar el contenido de un archivo
5. Borrar un archivo
6. Cambiar el nombre de un archivo
7. Borrar un directorio
9. Regresar
"

while [ : ]
do

 read -p "Ingresa la opcion: " option

 case $option in
  1) createDirectory;;
  2) copyFile;;
  3) changePermissonsOnFile;;
  4) readFile;;
  5) deleteFile;;
  6) renameFile;;
  7) deleteDirectory;;
  9) break;;
  *) echo "Opcion no valida!"
 esac

done

}
