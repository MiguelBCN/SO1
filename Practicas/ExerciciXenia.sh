#!/bin/bash

if [! -f $1];then
        echo "El fitxer $1 no existe."
        exit 1
fi

llista=$1
fitxers=$(cat $llista)
compt=0
for i in $fitxers
        if i in #!No se que poner
		;then
                	expr $compt + 1

echo "Existeixen: $compt"
echo "No existeixen: $(expr $#fitxers[*] - $compt)"

fi
