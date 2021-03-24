#/bin/bash

# Script que recibe como parametro un nombre de usuario y
# una cadena ya sea VSZ o RSS
#  Mostar los 10 primeros procesos ordenados de forma descendente por VSZ o RSS

# Comprabaciones
if [ $#  -ne 2 ];then
	echo "Numero de parametros erroneo se espera un nombre de usuario y (VSZ o RSS)"
	exit 1
fi
if [ -d $1  -o  -f $1 ];then
	echo "El primer parametro solo puede ser una nombre no poner archivos ni directorios"
	exit 1
fi
if ! [[   "$2" == "RSS"  || "$2" == "VSZ" ]] ;then
	echo "El segundo parametro solo puede ser VSZ o RSS"
	exit 1
fi

# Imprimir si el usuario no tiene procesos bajo su nombre
var=$(ps -aux | grep "^$1\b")
if [ $? -eq 1 ];then
	echo "El usuario $1 no tiene ningun proceso adjuntado"
	exit 1
fi

# Programa
if [ $2 == "VSZ" ];then
	ps -aux | grep "^$1\b" | awk '{print $5 " "$6 " " $11}' | sort --numeric-sort -k1 |head
else
	ps -aux | grep "^$1\b" | awk '{print $5 " "$6 " " $11}' | sort --numeric-sort -k2 |head
fi

exit 0