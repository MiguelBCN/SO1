#!/bin/bash

if [[ ! -d $1 || -z $2 ]]; then
	echo "Error en l'entrada"
	exit 1
fi

myfiles=$(ls "$1")
for f in $myfiles
do 
	echo "$f m'he quedat aqui"
	if [ -f $f ]; then
		echo "1"
		text=$(cat $f)
		for i in text
		do
			echo "2"
			if [[ $2 == *$i* ]]; then
				echo "$fitxer: $i"
			fi
		done
	fi
done
exit 0;
