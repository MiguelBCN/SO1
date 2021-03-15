#!/bin/bash

# Script para mostrar el peso de los subdirectorios

#Comprobar que el numero de parametros sea correcto
if [ $# -ne 1 ]
then
	echo "El numero de parametros es mayor a 1"
	exit 1
fi

#Comprobar que el fichero pasado existe y no es un directorio

if [ -f $1 -a ]
then
	echo "El archivo no es un directorio "
	exit 1
fi


# Programa
directorios=$(find $1 -type d)

for directorio in $directorios
do
	peso=0
	archivos=$(ls -Fal "$directorio"| grep -v \/|awk '{print $5}')
	for i in $archivos
	do 
		peso=$((peso + i))
		
	done
	echo "$peso $directorio"

done
exit 0