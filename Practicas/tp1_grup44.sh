#!/bin/bash

#Comprovar que el nombre de parametres sigui correcte
if [ $# -ne 1 ]
then
	echo "El nombre de parametros es major a 1"
	exit 1
fi

#Comprovar que el fitxer passat existeix i no és un directori

if [[ ! -f $1 && ! -d $1 ]]
then
	echo "L'arxiu no es un directori o el fitxer no existe"
	exit 1
fi

#Programa que rep un arxiu amb una llista d'arxius i torna el nombre de fitxers que existeixen

fitxer=$1
arxius=$(cat $fitxer)
existeixen=0
noExisteixen=0
for i in $arxius
do
	if [[ -f $i || -d $i ]]
	then
		existeixen=$((existeixen+1))
	else
		noExisteixen=$((noExisteixen+1))
	fi
done
echo "Existeixen: $existeixen"
echo "No existeixen: $noExisteixen"
exit 0

