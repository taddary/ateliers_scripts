#!/bin/bash
#
# FILE NAME
############
#sum_files_by_year.sh
#
# DESCRIPTION
#############
#Indique la somme de la taille des fichiers modifies selon une annee donnee dans un repertoire donne
#
# VARIABLES
############
DIR_PATH=$1
YEAR=$2
TEST_SIZE_RE='^[0-9]+$'
#
# MAIN
###########
if [ -d $DIR_PATH ]
	then
	SIZE=$(find $DIR_PATH -type f -newermt "${YEAR}0101" \! -newermt $((YEAR+=1))0101 -ls | awk '{sum+=$7} END {print sum}' )
	
	if ! [[ $SIZE =~ $TEST_SIZE_RE ]]
		then
		echo "Il n'y a pas de fichiers pour l'annee $YEAR"
		exit 2
	fi
	
	((SIZE=$SIZE / 1024))
	echo "$YEAR : $SIZE kilobytes"
	exit 0
else
	echo "$DIR_PATH n'est pas un repertoire valide"
	exit 1
fi
