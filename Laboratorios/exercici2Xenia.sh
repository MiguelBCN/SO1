#!/bin/bash

cd "$1"

if [[ ! -d $1 || -z $2 ]]; then
	echo "Error en l'entrada"
	exit 1
fi

myfiles=$(ls "$1")
for f in $myfiles 
do 
	if [ -f $f ]; then
		text=$(cat $f)
		for i in $text
		do
			if [[ "$i" == *"$2"* ]]; then
				echo "$f: $i"
			fi
		done
	fi
done
exit 0;
