#!/bin/bash

# Script para comprobar el tamaño de todos los archivos dentro de un directorio

# Comprobacion de numero de parametros
if [ $# -ne 1 ]S
then
	echo "El nombre de parametres introduits es incorrecte"
	exit 1
fi
# Comprobacion de de tipo de parametro
if [ ! -d $1 ]; then
	echo "No s'ha introduit un directori"
	exit 1
fi

# Guardamos la informacion del comando ls y luego revisamos las columunas de los archivos
# Con el comanod awk sumamos el tamaño de cada archivo que esta a la columna 5 si la columna 6 comprueba que sea un fichero
cd $1
ls -l > dades.txt
awk '{if (-f $6) total+=$5} END {print "La suma total de bytes dels fitxers es " total}' dades.txt

rm dades.txt

exit 0
