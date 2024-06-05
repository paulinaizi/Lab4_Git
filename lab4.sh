#!/bin/bash

print_today()
{
	today=$(date +"%Y-%m-%d")
	echo "$today"
}

while [ $# -gt 0 ]
do
	case "$1" in
		--date)
			print_today
			shift
			;;
		*)
			echo "Nieznana opcja"
			shift
			;;
	esac
done

