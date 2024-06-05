#!/bin/bash

print_today()
{
	today=$(date +"%Y-%m-%d")
	echo "$today"
}

make_logs()
{
	num=${1:-100}
	for ((i=1; i<=$num; i++));
	do
		local file="log${i}.txt"
		echo $file > $file
		echo $(basename $BASH_SOURCE) >> $file
		print_today >> $file
	done
}

help()
{
	echo "Dostępne opcje: "
	echo -e "--date 				Wyświetla dzisiejszą datę."
	echo -e "--logs [liczba] 	Tworzy określoną liczbę plików logx.txt, x – numer pliku, domyślna wartość liczby wynosi 100"
	echo -e "--help 				Wyświetla dostępne opcje."
}

while [ $# -gt 0 ]
do
	case "$1" in
		--date | -d)
			print_today
			shift
			;;
		--logs | -l)
			if [[ -n $2 ]] && [[ $2 =~ ^[0-9]+$ ]]; then
				make_logs $2
				shift 2
			else
				make_logs
				shift
			fi
			;;
		--help | -h)
			help
			shift
			;;
		*)
			echo "Nieznana opcja"
			shift
			;;
	esac
done

