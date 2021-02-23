#!/bin/bash

#Funció recursiva

obrimfitxers()
{

	paraula=$3
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
	return 0

}

		
paraulesdelfitxer()
{
	if [ -f $f ]; then
		text=$(cat $f)
		for i in $text
		do
			if [[ $i == $paraula ]]; then
				echo "$f: $i"
				return 0
			fi
		done
	fi
	return 0
}

#Funció main

cd "$1"

if [[ ! -d $1 || -f $2 || -z $3 ]]; then
	echo "Error en l'entrada"
	exit 1

	else
		myfiles=$(ls "$1")
		obrimfitxers "$myfiles" "$2" "$3"
		exit 0
fi

