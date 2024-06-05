#!/bin/bash

print_today()
{
	today=$(date +"%Y-%m-%d")
	echo "$today"
}

make_logs()
{
	num=${1:-10}
	for ((i=1; i<=$num; i++));
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
			if [[ -n $2 ]] && [[ $2 =~ ^[0-9]+$ ]]; then
				make_logs $2
				shift 2
			else
				make_logs
				shift
			fi
			;;
		*)
			echo "Nieznana opcja"
			shift
			;;
	esac
done

