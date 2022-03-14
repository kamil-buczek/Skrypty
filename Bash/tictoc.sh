#!/usr/bin/env bash


PLANSZA=("." "." "." "." "." "." "." "." "." ".")
GRACZ="1"
WYGRANA="0"
MARK="o"
LICZBA_TUR=9

BLEDNE_POLE="0"
ZAJETE_POLE="0"




function wyswietl {
	clear
	echo "###### Plansza #######"
	echo ""
	echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}    0 | 1 | 2"
	echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}    3 | 4 | 5"
	echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}    6 | 7 | 8"
	echo ""
	echo "Pozostala liczba tur to: ${LICZBA_TUR}"
}


function sprawdzKomorki {

	if [[ "${PLANSZA[${1}]}" == "${PLANSZA[${2}]}" ]] && \
	   [[ "${PLANSZA[${2}]}" == "${PLANSZA[${3}]}" ]] && \
	   [[ "${PLANSZA[${3}]}" == "${MARK}" ]]; then
		WYGRANA="1"
	fi
}


function sprawdzWygrana {


	
	if [[ ${LICZBA_TUR} -eq 0 ]]; then
		wyswietl
		echo "!!!! REMIS !!!"
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
		sprawdzKomorki 2 5 6
	fi 
	if [[ "${WYGRANA}" -ne "1" ]];then 
		sprawdzKomorki 0 4 6
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
	if [[ ${POLE} -lt 0 ]] || [[ ${POLE} -gt 8 ]];then
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


while [ "${WYGRANA}" -eq "0" ]
do
	wyswietl
	komunikatWyboruPola
	echo -e "\nGRACZ: ${GRACZ}\nProsze wybrac numer pola od 0 do 8"
	read POLE
	sprawdzWyborPola
	sprawdzWygrana
	zmienGracza

	if [[ ${?} -eq 1 ]]; then
		break
	fi
done


