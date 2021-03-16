#!/bin/bash

#Comprovació del nombre de paràmetres
if [ $# -ne 4 ]; then
	echo "El nombre de parametres introduits es incorrecte."
	exit 1
fi

#Comprovació del tipus de paràmetres
if [[ ! -d $1  || -f $2 || -d $2 || -f $3 || -d $3 || -f $4 || -d $4 ]]; then
	echo "Error: no ha introduit un fitxer o aquest no existeix."
	exit 1
fi

cad1=$3
cad2=$4

find $1 -type f -name "*.$2" -exec grep -E "\b$cad1\w*$cad2\b" -o {} \; | wc -l

exit 0
