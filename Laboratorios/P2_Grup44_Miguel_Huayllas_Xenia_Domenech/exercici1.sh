#!/bin/bash

#Comprovació del nombre de paràmetres
if [ $# -ne 2 ]
then
	echo "El nombre de parametres introduits es incorrecte."
	exit 1
fi

#Comprovació del tipus de paràmetres
if [[ ! -d $1 || -f $2 || -d $2 ]]; then
	echo "Error: no ha introduit un fitxer o aquest no existeix."
	exit 1
fi

echo "BYTES   DIRECTORI DEL FITXER"

find $1 -type f -name "*.$2" -printf "%s  %p\n"| sort -n

exit 0 
