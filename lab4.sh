#!/bin/bash

print_today()
{
	today=$(date +"%Y-%m-%d")
	echo "$today"
}

make_logs()
{
	for ((i=1; i<=100; i++));
	do
		local file="log${i}.txt"
		echo $file > $file
		echo $(basename $BASH_SOURCE) >> $file
		print_today >> $file
	done
}

while [ $# -gt 0 ]
do
	case "$1" in
		--date)
			print_today
			shift
			;;
		--logs)
			make_logs
			shift
			;;
		*)
			echo "Nieznana opcja"
			shift
			;;
	esac
done

