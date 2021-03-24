#!/bin/bash

#Comprovació del nombre de paràmetres
if [ $# -ne 1 ]
then
	echo "El nombre de parametres introduits es incorrecte."
	exit 1
fi

#Comprovació del tipus de paràmetres
if [[ ! -d $1 ]]; then
	echo "Error: no ha introduit un fitxer o aquest no existeix."
	exit 1
fi

subdirectoris=$(find $1 -type d)
for d in $subdirectoris
do
	fitxers=$(ls -Fl "$d" | grep -v \/ | awk '{print $5}')
	size=0
	for f in $fitxers
	do
		size=$((size + f))
	done
	echo "$size $d"
done

exit 0
