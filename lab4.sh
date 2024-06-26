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

error()
{
	num=${1:-100}
	for ((i=1; i<=$num; i++));
	do
		local dir="error${i}"
		local file="error${i}.txt"
		mkdir $dir
		echo $file > $dir/$file
		echo $(basename $BASH_SOURCE) >> $dir/$file
		print_today >> $dir/$file
	done
}

help()
{
	echo "Dostępne opcje: "
	echo "--date, -d				Wyświetla dzisiejszą datę."
	echo "--logs, -l [liczba] 		Tworzy określoną liczbę plików logx.txt, x – numer pliku, domyślna wartość liczby wynosi 100."
	echo "--error, -e [liczba] 		Tworzy określoną liczbę plików errorx/errorx.txt, x – numer pliku, domyślna wartość liczby wynosi 100."
	echo "--help, -h 				Wyświetla dostępne opcje."
	echo "--init					Klonuje całe repozytorium, do katalogu w którym został uruchomiony skrypt oraz ustawia ścieżkę w zmiennej środowiskowej PATH."
}

init()
{
	git clone https://github.com/paulinaizi/Lab4_Git.git .
	repo_path=$(pwd)
	PATH=$PATH:$repo_path
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
		--error | -e)
			if [[ -n $2 ]] && [[ $2 =~ ^[0-9]+$ ]]; then
				error $2
				shift 2
			else
				error
				shift
			fi
			;;
		--help | -h)
			help
			shift
			;;
		--init)
			init
			shift
			;;
		*)
			echo "Nieznana opcja"
			shift
			;;
	esac
done

