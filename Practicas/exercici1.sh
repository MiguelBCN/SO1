#!/bin/bash

#Comprobar que el numero de parametros sea correcto
if [ $# -ne 1 ]
then
	echo "El numero de parametros es mayor a 1"
	exit 1
fi

#Comprobar que el fichero pasado existe y no es un directorio

if [ ! -f $1 -a ! -e $1 ]
then
	echo "Ela rchivo no es un directorio o no existe"
	exit 1
fi

# Programa que recibe un archivo con una lista de archivos y devuelve el numero de los que existen

fichero=$1
archivos=$(cat $fichero)
existentes=0
noExistentes=${#archivos[*]}
for i in archivos
do
	if [ -e $i ]
	then
		existentes=$((existentes+1))
	else
		noExistentes=$((noExistentes-1))
	fi

done
echo "Numero de archivos existentes $existentes"
echo "Numero de archivos no existentes $noExistentes"
exit 0

