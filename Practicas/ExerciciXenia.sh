#!/bin/bash

if [ ! -f $1 ]; then
        echo "El fitxer $1 no existe."
        exit 1
fi

llista=$1
fitxers=$(cat $1)
compt=0; numfiles=0
for i in $fitxers
do
	numfiles=`expr $numfiles + 1`
        if [ -f $i ]; then
               	compt=`expr $compt + 1`
	fi
done

echo "Existeixen: $compt"
echo "No existeixen: `expr $numfiles - $compt`"
exit 0
