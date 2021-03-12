#!/bin/bash

#Comprovació del nombre de paràmetres
if [ $# -ne 3 ]
then
	echo "El nombre de parametres introduits es incorrecte."
	exit 1
fi

#Comprovació del tipus de paràmetres
if [[ ! -d $1 || -f $2 || -d $2 || -f $3 || -d $3 ]]; then
	echo "Error: no ha introduit un fitxer o aquest no existeix."
	exit 1
fi

fitxers=0
for f in $(find "$1" -type f -name "*$2")
do
	mv "$f" "${f%$2}$3"
	fitxers=$((fitxers+1))
done

echo "S'han modificar $fitxers fitxers"

exit 0	
