#!/bin/bash

#Funció recursiva

obrimfitxers()
{

	paraula=$3
	apareix=0
	for f in $myfiles
	do
		if [[ ! -d $f && ! -f $f ]]; then
			echo "Error en la lectura dels fitxers o dels directoris."
			return 1
		fi

		#Comprovo si tinc un fitxer amb l'extensió necessària

		if [[ -f $f && ${f#*.} == $2 ]]; then
			
			#Comprovo si el fitxer té la paraula demanada

			paraulesdelfitxer "$f" "$paraula"
		fi
		
		#Comprovo si tinc un subdirectori

		if [ -d $f ]; then

			#Em guardo els fitxers del subdirectori en "myfiles"

			myfiles=$(ls "$f")

			#Entro dins del subdirectori

			cd ./$f

			#Faig recursivitat

			obrimfitxers "$myfiles" "$2" "$paraula"

			#Torno al directori anterior

			cd ..
		fi
	done
	if [[ $apareix -eq 0 ]]; then
		echo "La cadena no apareix en cap fitxer"
	fi
	return 0

}

		
paraulesdelfitxer()
{
	if [ -f $f ]; then
		text=$(cat $f)
		for i in $text
		do
			if [[ $i == $paraula ]]; then
				echo "$(pwd)/$f"
				apareix=1
				return "$apareix"
			fi
		done
	fi
	return 0
}

#Funció main

cd "$1"

if [ $# -ne 3 ]
then
        echo "El nombre de parametres introduits es incorrecte"
        exit 1
fi

if [[ ! -d $1 || -z $2 || -z $3 ]]; then
	echo "Error en l'entrada"
	exit 1

	else
		myfiles=$(ls "$1")
		obrimfitxers "$myfiles" "$2" "$3"
		exit 0
fi

