#!/bin/bash

# Script per comprovar la mida de tots els arxius dins d'un directori

# Comprovació del nombre de paràmetres
if [ $# -ne 1 ]
then
	echo "El nombre de parametres introduits es incorrecte"
	exit 1
fi
# Comprovació tipus de paràmetres
if [ ! -d $1 ]; then
	echo "No s'ha introduit un directori"
	exit 1
fi

# Guardem la informació de la comanda ls i després revisem les columnes dels arxius.
# Amb la comanda awk sumem la mida de cada arxiu que està a la columna 5 si la columna 6 comprova que sigui un fitxer
cd $1
ls -l > dades.txt
awk '{if (-f $6) total+=$5} END {print "La suma total de bytes dels fitxers es " total}' dades.txt

rm dades.txt

exit 0
