#!/bin/bash
#start
zenity --info --text="Bienvenue dans la calculatrice,vieillez entrer!" --width=100 --height=100
#fonction factorial 
factorial(){
        res=1
        val=$1
        while [[ $val -gt 1 ]]; do
                res=`expr $res \* $val`
                val=`expr $val - 1`
        done
        echo $res
}
zenity --question --text="On commence?" --width=80 --height=80
if [[ $? = 0 ]]; then
        choix=$(whiptail --title "mode de calcul" --fb --menu "check" 15 60 3 \
                    "1" "calcul avec une seule operande" \
                    "2" "calcul avec deux operandes" \
                    "3" "base: bin/oct/dec/hex" 3>&1 1>&2 2>&3)
                    case $choix in
                1)
                        zenity --forms \
                        --title="La saisie des valeurs" \
                        --add-entry="Le nombre a calculer" > varr

                        if [[ $? = 0 ]]; then
                                var1=$(awk -F "|" '{print ($1)}' varr)
            if [[ -n "$(printf '%s\n' "$var1" | sed 's/[0-9,-]//g')" ]] || [[ -z $var1 ]]; then
                    zenity --error --text="Vieillez entrer un nombre la prochaine fois SVP!!"
            else

            OP1=$(whiptail --title "Operations" --fb --menu "check" 15 40 5 \
                    "1" "racine" \
                    "2" "logarithme" \
                    "3" "ln()" \
                    "4" "valeur absolue" \
                    "5" "factoriel" \
                    "6" "factorisation" \
                    "7" "exponentielle" \
                    "8" "inverse" 3>&1 1>&2 2>&3)
                                case $OP1 in
1)
                            v=$(awk -F "|" '{print($1)}' varr)
                            if [[ $v -lt 0 ]]; then
                            zenity --error --text="Operation erronee!!"
                    else
                            sqrt=$(awk -F "|" '{print sqrt($1)}' varr)
                            zenity --info --text="La racine carre est $sqrt" --width=200 --height=200
                    fi
                            ;;
                    2)
                           if [[ $var1 -lt 1 ]]; then
                                    zenity --error --text="Operation erronee"
                           else
                            log=$(awk -F "|" '{print log($1)/log(10)}' varr)
                            zenity --info --text="le resultat du ln est $log" --width=200 --height=200
                           fi
                            ;;
                    3)
                            l=$(awk -F "|" '{print ($1)}' varr)
                            if [[ $l -lt 1 ]]; then
                                    zenity --error --text="Operation erronee"
                            else
                               ln=$(awk -F "|" '{print log($1)}' varr)
                               zenity --info --text="le resultat est $ln" --width=200 --height=200
                                fi
                               ;;
                        4)
                            abs=$(awk -F "|" '{print ($1)}' varr)
                            if [[ abs -lt 0 ]]; then
                                    abs=$(awk -F "|" '{print $1*(-1) }' varr)
                            else
                                    abs=$(awk -F "|" '{print ($1)}' varr)
                            fi
                                    zenity --info --text=" la valeur absolue est $abs" --width=200 --height=200
                            ;;
                        5)
                        f=$(awk -F "|" '{print($1)}' varr)
                        if [[ $f -lt 0 ]]; then
                            zenity --error --text="Erreur: le nombre est négatif"
                        elif [[ $f -eq 0 ]]; then
                                zenity --info --text="Le resultat du factoriel est 1"
                        else
 		factor=$( factorial $f )
                                zenity --info --text="Le resultat du factorial est $factor"
                        fi
                            ;;
                        6)
		   #cette opération sert à donner la multiplication des nombres premiers dans un nombre
                                ffact=$(awk -F "|" '{print ($1)}' varr)
                                fff=`factor $ffact`
                                zenity --info --text="Le résultat de la factorisation est $fff"
                                ;;
                        7)
                              ex=$(awk -F "|" '{print($1)}' varr)
                              exp=$(echo "e($ex)" | bc -l )
                              zenity --info --text="le resultat est de l'exponentielle $exp"
                                ;;
                        8)
                                invr=$(awk -F "|" '{print ($1)}' varr)
                                if [[ invr -eq 0 ]]; then
                                        zenity --error --text="Erreur: 0 ne peux pas être sur le dénominateur!!"
                                else
                                        inv=$(awk -F "|" '{print 1/$1}' varr)
                                        zenity --info --text="L'inverse est $inv"
                                fi
                                ;;
                        *)
                         zenity --info --text="Aucune operation choisie!" --width=200 --height=200
                         ;;
         esac
            fi
 else exit
fi
                ;;
                2)
   zenity --forms \
    --title="La saisie des valeurs" \
    --add-entry="Le premier nombre" \
    --add-entry="Le deuxiem nombre" > var
    if [[ $? = 0 ]]; then
            var1=$(awk -F "|" '{print ($1)}' var)
var2=$(awk -F "|" '{print ($2)}' var)
            if [[ -n "$(printf '%s\n' "$var1" | sed 's/[0-9,-]//g')" ]] || [[ -n "$(printf '%s\n' "$var2" | sed 's/[0-9,-]//g')" ]] || [[ -z $var1 ]] || [[ -z $var2 ]]; then
                    zenity --error --text="Vieillez entrer un nombre la prochaine fois SVP!!"
                else
            OP2=$(whiptail --title "Operations" --fb --menu "check" 15 40 5 \
                    "1" "somme" \
                    "2" "soustraction" \
                    "3" "multiplication" \
                    "4" "division" \
                    "5" "modulo" \
                    "6" "puissance" 3>&1 1>&2 2>&3)
            case $OP2 in
                    1)
                            som=$(awk -F "|" '{print $1+$2}' var)
                            zenity --info --text="La resultat du somme est $som" --width=200 --height=200
                            ;;
                    2)
                           sous=$(awk -F "|" '{print $1-$2}' var)
zenity --info --text="Le resultat du soustraction est $sous" --width=200 --height=200
                           ;;
                    3)
                           mul=$(awk -F "|" '{print $1*$2}' var)
                           zenity --info --text="Le resultat du multiplication est$mul" --width=200 --height=200
                           ;;
                    4)
                            if [[ $var2 -eq 0 ]]; then
                                    zenity --error --text="Erreur: 0 ne peux pas être dans le dénominateur!!"
                            else
                          div=$(awk -F "|" '{print $1/$2}' var)
                        zenity --info --text="Le resultat du division est $div" --width=200 --height=200
                            fi
                         ;;
                    5)
                          if [[ $var2 -eq 0 ]]; then
                                  zenity --error --text="Erreur: 0 ne peux pas être sur le dénominateur!!"
                          else
                          mod=$(awk -F "|" '{print $1%$2}' var)
                          zenity --info --text="Le resultat de modulo est $mod" --width=200 --height=200
                          fi
                          ;;
                    6)
 a=$(awk -F "|" '{print ($1)}' var)
                            b=$(awk -F "|" '{print ($2)}' var)
                            if [[ $a -eq 0 && $b -eq 0 ]]; then
                            enity --error --text="Operation erronee"
                            else
                            pow=$(awk -F "|" '{print $1 ^ $2}' var)
                            zenity --info --text=" $1 a la puissance $2 est $pow" --width=200 --height=200
                            fi
                                ;;
                    *)
                         zenity --info --text="Aucune operation choisie!" --width=200 --height=200
                         ;;
         esac
            fi
 else exit
fi
                ;;
        3)
                base=$(whiptail --title "Transformations" --fb --menu "check" 15 40 5 \
                    "1" "Binary to octal" \
                    "2" "Binary to decimal" \
                    "3" "Binary to hexadecimal" \
                    "4" "Octal to Binary" \
                    "5" "Octal to decimal" \
                    "6" "Octal to hexadecimal" \
                    "7" "Decimal to binary" \
                    "8" "Decimal to octal" \
                    "9" "Decimal to hexadecimal" \
                    "10" "Hexadecimal to binary" \
                    "11" "Hexadecimal to octal" \
                    "12" "Hexadecimal to decimal" 3>&1 1>&2 2>&3)
                        case $base in
                                1)
                                zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre binaire" > binary
                                bin1=$(awk -F "|" '{print ($1)}' binary)
		   #la commande ci-dessous sert à vérifier si le nombre se compose seulement de 0 et 1
                                if [[ -n "$(printf '%s\n' "$bin1" | sed 's/[0-1]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas binaire!!"
                                else
		    #ibase pour la base de source et obase pour la base d’arrivée
                                        octal1=$( echo "ibase=2;obase=8;$bin1" | bc -l)
                                        zenity --info --text="Le nombre en octal est $octal1"
                                fi
   ;;
                                        2)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre binaire" > binary
                                bin2=$(awk -F "|" '{print ($1)}' binary)
                                if [[ -n "$(printf '%s\n' "$bin2" | sed 's/[0-1]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas binaire!!"
                                else
                                        decimal1=$( echo "ibase=2;$bin2" | bc -l)
                                        zenity --info --text="Le nombre en decimal est $decimal1"
                                fi
                                        ;;
                                        3)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre binaire" > binary
                                bin3=$(awk -F "|" '{print ($1)}' binary)
                                if [[ -n "$(printf '%s\n' "$bin3" | sed 's/[0-1]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas binaire!!"
                                else
                                        hexadecimal1=$( echo "ibase=2;obase=10000;$bin3" | bc -l)
                                        zenity --info --text="Le nombre en hexadecimal est $hexadecimal1"
                                fi
                                        ;;
                                        4)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre octal" > octal
                                oct1=$(awk -F "|" '{print ($1)}' octal)
                                if [[ -n "$(printf '%s\n' "$oct1" | sed 's/[0-7]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas octal!!"
                                else
                                        binary1=$( echo "obase=2;ibase=8;$oct1" | bc -l)
                                        zenity --info --text="Le nombre en binaire est $binary1"
                                fi
                                        ;;
                                        5)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre octal" > octal
oct2=$(awk -F "|" '{print ($1)}' octal)
                                if [[ -n "$(printf '%s\n' "$oct2" | sed 's/[0-7]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas octal!!"
                                else
                                        decimal2=$( echo "ibase=8;$oct2" | bc -l)
                                        zenity --info --text="Le nombre en decimal est $decimal2"
                                fi
                                ;;
                                        6)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre octal" > octal
                                oct3=$(awk -F "|" '{print ($1)}' octal)
                                if [[ -n "$(printf '%s\n' "$oct3" | sed 's/[0-7]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas octal!!"
                                else
                                        hexadecimal2=$( echo "obase=16;ibase=8;$oct3" | bc -l)
                                        zenity --info --text="Le nombre en hexadecimal est $hexadecimal2"
                                fi
                                        ;;
                                        7)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre decimal" > decimal
                                dec1=$(awk -F "|" '{print ($1)}' decimal)
                                if [[ -n "$(printf '%s\n' "$dec1" | sed 's/[0-9]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas decimal!!"
                                else
                                        binary2=$( echo "obase=2;$dec1" | bc -l)
                                        zenity --info --text="Le nombre en binaire est $binary2"
                                fi
                                        ;;
                                        8)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre decimal" > decimal
                                dec2=$(awk -F "|" '{print ($1)}' decimal)
                                if [[ -n "$(printf '%s\n' "$dec2" | sed 's/[0-9]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas decimal!!"
                                else
octal2=$( echo "obase=8;$dec2" | bc -l)
                                        zenity --info --text="Le nombre en octal est $octal2"
                                fi
                                        ;;
                                        9)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre decimal" > decimal
                          dec3=$(awk -F "|" '{print ($1)}' decimal)
                                if [[ -n "$(printf '%s\n' "$dec3" | sed 's/[0-9]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas decimal!!"
                                else
                                        hexadecimal3=$( echo "obase=16;$dec3" | bc -l)
                                        zenity --info --text="Le nombre en hexadecimal est $hexadecimal3"
                                fi
                                        ;;
                                        10)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre hexadecimal" > hexadecimal
                                hex1=$(awk -F "|" '{print ($1)}' hexadecimal)
                                if [[ -n "$(printf '%s\n' "$hex1" | sed 's/[0-9A-F]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas hexadecimal!!"
                                else
                                        binary3=$( echo "ibase=16;obase=2;$hex1" | bc -l)
                                        zenity --info --text="Le nombre en binaire est $binary3"
                                fi
                                        ;;
                                        11)
                                        zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre hexadecimal" > hexadecimal
                                hex2=$(awk -F "|" '{print ($1)}' hexadecimal)
                                if [[ -n "$(printf '%s\n' "$hex2" | sed 's/[0-9A-F]//g')" ]]; then
                                        zenity --error --text="Erreur: le nombre n'est pas hexadecimal!!"
                                else
                                        octal3=$( echo "ibase=16;obase=8;$hex2" | bc -l)
                                        zenity --info --text="Le nombre en octal est $octal3"
                                fi
                                        ;;
                                        12)
   zenity --forms \
                                --title="La saisie de la valeur" \
                                --add-entry="Le nombre hexadecimal" > hexadecimal

                                hex3=$(awk -F "|" '{print ($1)}' hexadecimal)
                                if [[ -n "$(printf '%s\n' "$hex3" | sed 's/[0-9A-F]//g')" ]]; then
                                zenity --error --text="Erreur: le nombre n'est pas hexadecimal!!"
                                else
                                        decimal3=$( echo "ibase=16;$hex3" | bc -l)
                                        zenity --info --text="Le nombre en decimal est $decimal3"
                                fi
                                        ;;
                                        *)
                                        zenity --info --text="Au revoir!!"
                                        ;;
                        esac
                ;;
        *)
                zenity --info --text="Au revoir!!"
                ;;
        esac
else
            zenity --error --text="Merci,Au revoir!"
fi
