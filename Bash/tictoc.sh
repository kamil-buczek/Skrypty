#!/usr/bin/env bash


PLANSZA=("." "." "." "." "." "." "." "." "." ".")
GRACZ="1"
WYGRANA="0"
MARK="o"
LICZBA_TUR=9

BLEDNE_POLE="0"
ZAJETE_POLE="0"

PLIK_Z_ZAPISAMI="saves.txt"
GAME_MODE=""



function wyswietl {
	clear
	echo "###### Plansza #######"
	echo ""
	echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}    0 | 1 | 2"
	echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}    3 | 4 | 5"
	echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}    6 | 7 | 8"
	echo ""
	echo "Pozostala liczba tur to: ${LICZBA_TUR}"
	echo "Tryb gry: ${GAME_MODE}"
	echo "Press s to save game"
}


function sprawdzKomorki {

	echo "Spr: ${1} ${2} ${3} ${MARK}" >> test.txt

	if [[ "${PLANSZA[${1}]}" == "${PLANSZA[${2}]}" ]] && \
	   [[ "${PLANSZA[${2}]}" == "${PLANSZA[${3}]}" ]] && \
	   [[ "${PLANSZA[${3}]}" == "${MARK}" ]]; then
		WYGRANA="1"
	fi
}


function sprawdzWygrana {


	if [[ ${LICZBA_TUR} -le 0 ]]; then
		wyswietl
		echo "REMIS !!!"
		return 1

	fi

	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 0 1 2
	fi
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 3 4 5
	fi
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 6 7 8 
	fi
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 0 3 6
	fi
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 1 4 7
	fi
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 2 5 8
	fi 
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 0 4 8
	fi 
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 6 4 2
	fi


	if [[ "${WYGRANA}" -eq "1" ]]; then
		wyswietl
		echo "Wygrał gracz ${GRACZ}"
		return 1
	fi

}


function zmienGracza {
	if [ "${GRACZ}" -eq "1" ];
	then
		GRACZ="2"
		MARK="x"
	else
		GRACZ="1"
		MARK="o"
	fi
}

function komunikatWyboruPola {

	if [[ "${BLEDNE_POLE}" -eq "1" ]]; then
		echo -e "\nPodano zly numer pola"
		BLEDNE_POLE="0"
	elif [[ "${ZAJETE_POLE}" -eq "1" ]]; then
		echo -e "\nTo pole jest juz zajete"
		ZAJETE_POLE="0"
	fi
}


function sprawdzWyborPola {
	if [[ "${POLE}" == "s" ]]; then
		echo "Zapisywanie gry"
		zapiszGre
		exit 0
	elif [[ ${POLE} -lt 0 ]] || [[ ${POLE} -gt 8 ]];then
		BLEDNE_POLE="1"
		continue
	elif [[ "${PLANSZA["${POLE}"]}" == "o" ]] || [[ "${PLANSZA["${POLE}"]}" == "x" ]];then
		ZAJETE_POLE="1"
		continue
	else

		PLANSZA[${POLE}]="${MARK}"
		LICZBA_TUR=$((${LICZBA_TUR}-1))
	fi
}



function zapiszGre {
	echo "Podaj nazwe zapisu: "
	read save_name
	echo "${save_name} | ${GAME_MODE} | ${PLANSZA[0]} | \
${PLANSZA[1]} | ${PLANSZA[2]} | ${PLANSZA[3]} | \
${PLANSZA[4]} | ${PLANSZA[5]} | ${PLANSZA[6]} | \
${PLANSZA[7]} | ${PLANSZA[8]}" >> "${PLIK_Z_ZAPISAMI}"
}


function gra_pvp {

	while [ "${WYGRANA}" -eq "0" ]
	do
		wyswietl
		komunikatWyboruPola
		echo -e "\nGRACZ: ${GRACZ}\nProsze wybrac numer pola od 0 do 8"
		read POLE
		sprawdzWyborPola
		sprawdzWygrana

		if [[ ${?} -eq 1 ]]; then
			break
		fi

		zmienGracza

	done
}



function main_menu {

	clear
	echo "#################  KOLKO i KRZYZYK  ###################"
	echo "1. New game"
	echo "2. Load game"
	read CHOICE

	if [[ "${CHOICE}" -eq "1" ]]; then
		mode_menu
	elif [ "${CHOICE}" -eq "2" ];then
		load_menu
	fi
}

function show_saves {

	cat "${PLIK_Z_ZAPISAMI}" | while read line; do
  		echo $line
	done
}

function get_save {

	

	cat "${PLIK_Z_ZAPISAMI}" | while read line; do
  		local nazwa=$( echo ${line} | cut -d '|' -f1 | xargs)
  		if [[ "${save_to_load}" == "${nazwa}" ]]; then
  			echo "${line}" | cut -d '|' -f2-
  			break 			
  		fi
	done
}


function load_save {

	local save_to_load="${1}"
	local save_string=$(get_save "${1}")
	

	counter=0

	IFS="|"

	first=0
	array_counter=0

	for i in ${save_string[@]}
	do
		if [[ ${first} -eq 0 ]]; then
			GAME_MODE=$( echo ${i} | xargs )
			first=1
		else
			PLANSZA[${array_counter}]=$( echo ${i} | xargs )
			array_counter=$((array_counter+1))
		fi
		
	done

}


function load_menu {
	clear
	echo "Choose save to load:"
	show_saves
	echo "Wybierz zapis do wczytania, podajac nazwe (pierwsza kolumna)"
	read load_choice
	echo "Wczytywania ${load_choice}"
	load_save "${load_choice}"

	if [[ "${GAME_MODE}" == "pvp" ]]; then
		gra_pvp
	fi
}

function mode_menu {

	clear
	echo "Choose game mode:"
	echo "1. Player vs player (pvp)"
	echo "2. Player vs computer (pve)"
	echo ""
	read mode_choice


	if [[ "${mode_choice}" -eq "1" ]]; then
		GAME_MODE="pvp"
		gra_pvp
	fi
}


main_menu