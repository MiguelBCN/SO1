#!/bin/bash

#Comprovació del nombre de paràmetres
if [ $# -ne 1 ]
then
	echo "El nombre de parametres introduits es incorrecte."
	exit 1
fi

#Comprovació del tipus de paràmetres
if [ ! -f $1 ]; then
	echo "Error: no ha introduit un fitxer o aquest no existeix."
	exit 1
fi

mv $1 $(echo "$1" | sed 's/[%@:]/-/g')

exit 0
