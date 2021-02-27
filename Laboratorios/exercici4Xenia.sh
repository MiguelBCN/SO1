#!/bin/bash

if [ $# -ne 1 ]
then
	echo "El nombre de parametres introduits es incorrecte"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "No s'ha introduit un directori"
	exit 1
fi

cd $1
ls -l > dades.txt
awk '{if ($2==1) total+=$5} END {print "La suma total de bytes dels fitxers es " total}' dades.txt

rm dades.txt

exit 0
