#!/bin/bash

if [ $# -ne 2 ]
then
        echo "El nombre de parametres introduits es incorrecte"
        exit 1
fi

if [[ ! -d $1 || -z $2 ]]; then
	echo "Error en l'entrada"
	exit 1
fi

cd "$1"
myfiles=$(ls "$1")
apareix=0
for f in $myfiles 
do 
	if [ -f $f ]; then
		text=$(cat $f)
		for i in $text
		do
			if [[ "$i" == *"$2"* ]]; then
				echo "$f: $i"
				apareix=1
			fi
		done
	fi
done

if [[ $apareix -eq 0 ]]; then
	echo "La cadena $2 no apareix en cap fitxer d'aquest directori"
fi
exit 0;
