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

#Comprovo quines lletres de $1 són caràcters especials i les substitueixo per un guió
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
echo "Fitxer reanomenat a $renom"
mv $nom $renom
exit 0 
