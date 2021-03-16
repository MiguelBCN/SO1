# Buscar en un directorio el numero de ficheros de cada suibdirectorio
# Comprobaciones
if [ $# -ne 1 ];then
	echo "Se necesita solo un parametro"
	exit 1
fi
if [ ! -d $1 ];then
	echo "El parametro solo puede ser un directorio"
	exit 1
fi

directorios=$(find "$1" -type d)
for i in $directorios
do
	peso=$(ls -F "$i"| grep -v \/ | wc -l)
	echo "directori: $i nfiles: $peso"
done
exit 0
