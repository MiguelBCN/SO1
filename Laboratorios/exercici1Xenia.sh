#!/bin/bash

if [ -z $1 ]; then
	echo "Error en el nom"
	exit 1
fi

nom=$1
for (( i = 0; i < ${#nom}; i++ ))
do
	lletra=${nom:i:1}
	if [[ $lletra == ":" || $lletra == "%" || $lletra == "@" ]]; then
		renom+="-"
	else
		renom+=$lletra
	fi
done
echo "$renom"
mv $nom $renom
exit 0 
