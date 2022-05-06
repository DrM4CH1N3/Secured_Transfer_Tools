#!/bin/bash
###############################################
#     --SCP Transfer files & Backup--         #
#        --Simple Bash Training--             #
#---------------------------------------------#
# Creator : Cedric H.                         #
# Version : 1.0                               #
# Last update : 05/05/2022                    #
###############################################
#Colors
red="\e[1;31m"
white="\e[1;37m"
blue="\e[34m"
green="\e[1;32m"
yellow="\e[1;33m"
qst="\e[1;31;1;41m"
line="\e[1;37;1;40m"
endcol="\e[0m"
#Function Return Menu
    function return_menu 
        {
                echo "Back to Menu [X]"
                read returnm
                if [[ $returnm =~ ^[x|X]$ ]] ; 
                    then
                    clear
                    menu
                fi
        }
clear
#=============INTRO===========================
clear
echo -e "\n\n\n\n$red Code by Cedric H. $endcol "

for i in 𝕯 𝖗. 𝕸 𝖆 𝖈 𝖍 𝖎 𝖓 𝖊
do
    echo -e "$red$i$endcol\c"
    sleep 0.125
done
sleep 0.25
clear
printf "$red"
printf "  ___ ___ ___ _   _ ___ ___ ___                  \n"                 
printf " / __| __/ __| | | | _ \ __|    \                \n"              
printf " \__ \ _| (__| |_| |   / _|   |  |              \n"           
printf " |___/___\___|\___/|_|_\___| ___/___ ___   $endcol$white\n"
printf "  |_   _| _ \  /_\ | \| / __| __| __| _ \   \n"
printf "    | | |   / / _ \|    \__ \ _|| _||   /   \n"
printf "    |_|_|_|_\/_/_\_\_|\_|___/_| |___|_|_\   $endcol$red\n"
printf "   |_   _/ _ \ / _ \| |  / __|                  \n"
printf "     | || (_) | (_) | |__\__ \                  \n"
printf "     |_| \___/ \___/|____|___/                  \n$red"
sleep 1
#=============INTRO===========================
        function menu 
    {
                                      
            

            clear
            check_scp=$(dpkg -s scp | head -n 1 )
            check_gpg=$(dpkg -s gpg | head -n 1 )

            if [[ "$check_scp" =~ "Package: scp" ]] || [[ "$check_gpg" =~ "Package: gpg" ]]
                then
                clear
                echo "#####################"
                else
                while true
                    do
                    printf "\033[41m\033[93mThis script need SCP & GPG to run.\n"
                    printf "Would you like to install it ?\n\e[0m"
                    echo "(Type : [Y] for Yes [N] for No)"
                    read OoN
                    if [[ "$OoN" =~ ^[y|Y]$ ]]
                        then
                        sudo apt install scp -y && sudo apt install gpg
                        break

                        else
                        exit 0
                    fi
                done
            fi
            clear 
            echo -e "SECURED $endcol$white TRANSFER $endcol$red TOOLS$endcol $white"                               
            echo -e "================\> "
            echo -e "|    |$endcol$blue SFT$endcol$white |||  \\   ___"
            echo -e "|____|_____|||_/_\\_|___|__ $endcol $blue"
            echo -e "<|  ___\    ||     | ____  |"
            echo -e "<| /    |___||_____|/    | |"
            echo -e "||/  O  |__________/  O  |_||"
            echo -e "   \___/  $encol$white   MENU $endcol$blue  \___/   "
            echo -e "$endcol$line-----------------------------$endcol$red"
            echo -e "【$encol$white 1$endcol$red 】-【$encol$white Download$endcol$red 】"
            echo -e "【$encol$white 2$endcol$red 】-【$encol$white  Upload$endcol$red  】"
            echo -e "【$encol$white 3$endcol$red 】-【$encol$white  Backup$endcol$red  】"
            echo -e "【$encol$white 4$endcol$red 】-【$encol$white  Pinned$endcol$red  】"
            echo -e "【$encol$white 5$endcol$red 】-【$encol$white   Exit$endcol$red   】"
            echo -e "$endcol$line-----------------------------$endcol$red"

                read saisie
                case $saisie in

                    1)
                        clear
                        function download {
                        echo -e "$red---------------------------------------------"
                        echo -e " ▐▐▐▐▐▐▐▐▐▐       DOWNLOAD       ▐▐▐▐▐▐▐▐▐▐  "
                        echo -e "---------------------------------------------$endcol\n"
                        }
                        download
                        echo -e "$endcol$qst would you like use a pinned host ? $endcol"
                        echo -e "$yellow (Type : [Y] for Yes [N] for No) $endcol"
                        read ask_host
                        clear
                        download
                            if [[ "$ask_host" =~ ^[y|Y]$ ]]
                                then
                                #liste des hosts
                                choose_host=$(ls | find *.gpg | awk -F . '{$NF=""; print $1}')
                                write_tmp1=$(echo "$choose_host" > /tmp/pinned_hosts.txt)
                                
                                echo -e "Choose your pinned host :"
                                echo -e "---------------------------------------------"
                                #echo -e "$choose_host"
                                ch=$(ls -1q *.gpg | wc -l)
                                    #point de démarrage à 1
                                    m=1
                                    
                                    until [ $m -gt $ch ]
                                        do
                                        host_by=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$m'')
                                        echo -e "[$m] $host_by"
                                        
                                        (( m=m+1 ))
                                    done

                                echo -e "---------------------------------------------"
                                read choice
                                if [[ -z $choice ]]
                                    then
                                    echo -e "ERROR !"
                                    sleep 2
                                    clear
                                    menu
                                    else
                                    host_slct=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$choice'')
                                    echo -e "$host_slct.sft_pinned.gpg"
                                    new_var=$(gpg -d $host_slct.sft_pinned.gpg)
                                    clear
                                    #user
                                    usr_sv=$(echo $new_var | awk '{print $1}')
                                    #IP
                                    ip_sv=$(echo $new_var | awk '{print $3}')
                                    #port
                                    port_sv=$(echo $new_var | awk '{print $5}')
                                    #sleep 5
                                fi
                                sleep 1
                                else
                                echo "Lets go"
                            fi
                                clear
                                download
                                echo -e "$endcol$qst Enter the name of file/folder do you want to download ? $endcol"
                                echo -e "$yellow (Example:  Photo.tar or Photos ) $endcol"
                                read fil
                                clear
                                download
                                echo -e "$endcol$qst In which directory is the file/folder located ? $endcol"
                                echo -e "$yellow (Example:  /home/user01/) $endcol"
                                read rep
                                clear
                                download
                                echo -e "$endcol$qst Where do you want to download this file/folder ? $endcol"
                                echo -e "$yellow (Example:  /tmp/) $endcol"
                                read rep2
                                clear
                                download
                                if [[ -z $usr_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the user : $endcol"
                                    echo -e "$yellow (Example:  user01) $endcol"
                                    read username
                                    else
                                    username=$usr_sv
                                fi
                                clear
                                download
                                if [[ -z $ip_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the ip or domaine : $endcol"
                                    echo -e "$yellow (Example:  192.168.1.25) $endcol"
                                    read server
                                    else
                                    server=$ip_sv
                                fi
                                clear
                                download
                                if [[ -z $port_sv ]]
                                    then
                                        echo -e "$endcol$qst Do you want to specify a connection port ? [22 by default] $endcol"
                                        echo -e "$yellow (Example:  2222) $endcol"
                                        read port
                                            if [[ $port -ne "22" ]]
                                                then
                                                port2=$port
                                                else
                                                port2="22"
                                            fi
                                    else
                                    port2=$port_sv
                                fi       
                        clear
                        download
                        echo -e "$green---------------------------------------------"
                        echo -e "Host:$server:$port  "
                        echo -e "User:$username  "
                        echo -e "To:$rep$fil  "
                        echo -e "In:$rep2  "
                        echo -e "---------------------------------------------$endcol"
                        scp -P $port2 $username@$server:$rep$fil $rep2
                        rm -f /tmp/pinned_hosts.txt
                        sleep 4
                        clear
                        menu
                    ;;

                    2)
                        clear
                        function upload {
                        echo -e "$red---------------------------------------------"
                        echo -e " ▐▐▐▐▐▐▐▐▐▐        UPLOAD        ▐▐▐▐▐▐▐▐▐▐  "
                        echo -e "---------------------------------------------$endcol\n"
                        }
                        upload
                        echo -e "$endcol$qst would you like use a pinned host ? $endcol"
                        echo -e "$yellow (Type : [Y] for Yes [N] for No) $endcol"
                        read ask_host
                        clear
                        upload
                                if [[ "$ask_host" =~ ^[y|Y]$ ]]
                                    then
                                    #liste des hosts
                                    choose_host=$(ls | find *.gpg | awk -F . '{$NF=""; print $1}')
                                    write_tmp1=$(echo "$choose_host" > /tmp/pinned_hosts.txt)
                                    
                                    echo -e "Choose your pinned host :"
                                    echo -e "---------------------------------------------"
                                    #echo -e "$choose_host"
                                    ch=$(ls -1q *.gpg | wc -l)
                                       
                                        m=1      
                                        
                                        until [ $m -gt $ch ]
                                            do
                                            host_by=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$m'')
                                            echo -e "[$m] $host_by"
                                           
                                            (( m=m+1 ))
                                        done
                                    echo -e "---------------------------------------------"
                                    read choice
                                    if [[ -z $choice ]]
                                        then
                                        echo -e "ERROR !"
                                        sleep 2
                                        clear
                                        menu
                                        else
                                        host_slct=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$choice'')
                                        echo -e "$host_slct.sft_pinned.gpg"
                                        new_varu=$(gpg -d $host_slct.sft_pinned.gpg)
                                        clear
                                        #user
                                        usru_sv=$(echo $new_varu | awk '{print $1}')
                                        #IP
                                        ipu_sv=$(echo $new_varu | awk '{print $3}')
                                        #port
                                        portu_sv=$(echo $new_varu | awk '{print $5}')
                                        #sleep 5
                                    fi
                                    sleep 1  
                                    else
                                    echo "Lets go"
                                fi
                                clear
                                upload
                                echo -e "$endcol$qst Enter the name of file/folder do you want to upload ? $endcol"
                                echo -e "$yellow (Example:  Photo.tar or Photos ) $endcol"
                                read filu
                                clear
                                upload
                                echo -e "$endcol$qst In which directory is the file/folder located ? $endcol"
                                echo -e "$yellow (Example:  /home/user01/Documents/) $endcol"
                                read repu
                                clear
                                upload
                                echo -e "$endcol$qst Where do you want to upload this file/folder ? $endcol"
                                echo -e "$yellow (Example:  /home/user01) $endcol"
                                read repu2
                                clear
                                upload
                                if [[ -z $usru_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the user : $endcol "
                                    echo -e "$yellow (Example:  user01) $endcol"
                                    read usernameu
                                    else
                                    usernameu=$usru_sv
                                fi
                                clear
                                upload
                                if [[ -z $ipu_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the ip or domaine : $endcol "
                                    echo -e "$yellow (Example:  192.168.1.25) $endcol"
                                    read serveru
                                    else
                                    serveru=$ipu_sv
                                fi
                                clear
                                upload
                                if [[ -z $portu_sv ]]
                                    then
                                        echo -e "$endcol$qst Do you want to specify a connection port ? [22 by default] $endcol "
                                        echo -e "$yellow (Example:  2222) $endcol"
                                        read portu
                                            if [[ $portu -ne "22" ]]
                                                then
                                                portu2=$portu
                                                else
                                                portu2="22"
                                            fi
                                    else
                                    portu2=$portu_sv
                                fi
                                    clear
                                    upload
                                    echo -e "$green---------------------------------------------"
                                    echo -e "Host:$serveru:$portu2  "
                                    echo -e "User:$usernameu  "
                                    echo -e "To:$repu$filu  "
                                    echo -e "In:$repu2  "
                                    echo -e "---------------------------------------------$endcol"
                                    #scp fichier.txt utilisateur@exemple.com:/chemin/vers/répertoire
                                    scp -P $portu2 $repu$filu $usernameu@$serveru:$repu2
                                    rm -f /tmp/pinned_hosts.txt
                                    sleep 4
                                    clear
                                    menu
                        
                    ;;

                    3)
                        clear
                        function backup {
                        echo -e "$red---------------------------------------------"
                        echo -e " ▐▐▐▐▐▐▐▐▐▐        BACKUP        ▐▐▐▐▐▐▐▐▐▐  "
                        echo -e "---------------------------------------------$endcol\n"
                        }
                        backup
                            echo -e "$red--------------------------------------------"
                            echo "[1]  Create New Backup"
                            echo "[2]  Show All Backups"
                            echo "[3]  Menu"
                            echo -e "--------------------------------------------$endcol"
                            read backp
                            case $backp in

                            1)
                            clear
                            backup
                            echo -e "$endcol$qst Do you want to compress the file ? $endcol "
                            echo -e "$yellow (Type : [Y] for Yes [N] for No) $endcol"
                            read compress
                            clear
                            backup
                                if [[ "$compress" =~ ^[y|Y]$ ]]
                                    then
                                    echo "Choose type of compression:"
                                    echo -e "-----------------------------"
                                    echo "[1] Higher compression ratio (.tar.gz)"
                                    echo "[2] Normal compression ratio (.tar)"
                                    echo -e "-----------------------------"
                                    read comp_choice
                                    if [[ $comp_choice -eq "1" ]]
                                        then
                                        tar=$( echo "-czf" )
                                        else
                                        tar=$( echo "-xf" )
                                    fi
                                    else
                                    echo "Lets go !"
                                fi
                                clear
                                backup
                                echo -e "$endcol$qst Choose the file or folder to backup : $endcol "
                                echo -e "$yellow (Example:  photos01.jpg or Photos ) $endcol"
                                read filback
                                clear
                                backup
                                echo -e "$endcol$qst In which directory is the file/folder located ? $endcol "
                                echo -e "$yellow (Example:  /home/user01/Pictures/) $endcol"
                                read foldback
                                clear
                                backup
                                echo -e "$endcol$qst In which folder do you want to backup ? $endcol "
                                echo -e "$yellow (Example:  /home/user01/MyBackup/) $endcol"
                                read fold2back
                                clear
                                backup
                                echo -e "$endcol$qst would you like use a pinned host ? $endcol"
                                echo -e "$yellow (Type : [Y] for Yes [N] for No) $endcol"
                                read ask_host
                                clear
                                backup
                                    if [[ "$ask_host" =~ ^[y|Y]$ ]]
                                        then
                                        #liste des hosts
                                        choose_host=$(ls | find *.gpg | awk -F . '{$NF=""; print $1}')
                                        write_tmp2=$(echo "$choose_host" > /tmp/pinned_hosts.txt)
                                        
                                        echo -e "Choose your pinned host :"
                                        echo -e "---------------------------------------------"
                                        #echo -e "$choose_host"
                                        ch=$(ls -1q *.gpg | wc -l)
                                            
                                            m=1
                                            
                                            until [ $m -gt $ch ]
                                                do
                                                host_by=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$m'')
                                                echo -e "[$m] $host_by"
                                                
                                                (( m=m+1 ))

                                            done
                                        echo -e "---------------------------------------------"
                                        read choice
                                        if [[ -z $choice ]]
                                            then
                                            echo -e "ERROR !"
                                            sleep 1
                                            clear
                                            menu
                                            else
                                            host_slct=$(cat /tmp/pinned_hosts.txt | awk 'NR=='$choice'')
                                            echo -e "$host_slct.sft_pinned.gpg"
                                            new_varb=$(gpg -d $host_slct.sft_pinned.gpg)
                                            clear
                                            #user
                                            usrb_sv=$(echo $new_varb | awk '{print $1}')
                                            #IP
                                            ipb_sv=$(echo $new_varb| awk '{print $3}')
                                            #port
                                            portb_sv=$(echo $new_varb | awk '{print $5}')
                                            #sleep 5
                                        fi
                                        sleep 1
                                if [[ -z $usrb_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the user : $endcol "
                                    echo -e "$yellow (Example:  user01) $endcol"
                                    read usernameb
                                    else
                                    usernameb=$usrb_sv
                                fi
                                clear
                                upload
                                if [[ -z $ipb_sv ]]
                                    then
                                    echo -e "$endcol$qst Enter the ip or domaine : $endcol "
                                    echo -e "$yellow (Example:  192.168.1.25) $endcol"
                                    read serverb
                                    else
                                    serverb=$ipu_sv
                                fi
                                clear
                                upload
                                if [[ -z $portb_sv ]]
                                    then
                                        echo -e "$endcol$qst Do you want to specify a connection port ? [22 by default] $endcol "
                                        echo -e "$yellow (Example:  2222) $endcol"
                                        read portb
                                            if [[ $portb -ne "22" ]]
                                                then
                                                portb2=$portu
                                                else
                                                portb2="22"
                                            fi
                                    else
                                    portb2=$portu_sv
                                fi
                                        else
                                        echo "Lets go"
                                    fi
                            clear
                            backup
                            #tar -cvf /tmp/fichier.txt.tar.gz /home/user01/Documents/fichier.txt
                                if [[ $tar -eq "-czf" ]]
                                    then
                                    lclfolder=$(echo $PWD)
                                    rdy_backup=$( echo "$lclfolder$filback.tar.gz" )
                                    tar $tar $lclfolder$filback.tar.gz $foldback$filback
                                    else
                                    lclfolder=$(echo $PWD)
                                    rdy_backup=$( echo "$lclfolder$filback.tar" )
                                    tar $tar $lclfolder$filback.tar $foldback$filback
                                fi
                            clear
                            backup
                            scp -P $portb2 $rdy_backup $usernameb@$serverb:$repb2
                            date=$(date | awk '{print $2$3, $7}' )
                            echo "$date : $filback ==> $host_by" >> mybackups
                            ;;

                            2)
                            clear
                            backup
                            cat=$(cat -u mybackups)
                            if [[ -z $cat ]]
                            then
                            clear
                            backup
                            echo "You don't have any yet Backups"
                            else
                            cat mybackups
                            fi
                            sleep 2
                            return_menu
                            ;;

                            3)
                            clear
                            menu
                            ;;

                            *)

                            ;;

                            esac
                    
                    ;;

                    4)
                        function pinned {
                        echo -e "$red---------------------------------------------"
                        echo -e " ▐▐▐▐▐▐▐▐▐▐        PINNED         ▐▐▐▐▐▐▐▐▐▐  "
                        echo -e "---------------------------------------------$endcol\n"
                        }
                        clear
                        pinned
                        echo -e "[1]  Create New "
                        echo -e "[2]  Show All Pinned "
                        echo -e "[3]  Back to Menu "
                        sleep 1
                        read menu_pinned
                        case $menu_pinned in
                            
                            1)
                                clear
                                pinned
                                
                                while true
                                    do
                                    echo -e "Would you want save your favorite Host ? "
                                    echo "(Type : [Y] for Yes [N] for No)"
                                    read OoN
                                    if [[ "$OoN" =~ ^[y|Y]$ ]]
                                        then
                                            clear
                                            pinned
                                            echo -e "Enter the IP or Domain : "
                                            read saved_ip
                                            echo -e "Enter the Username : "
                                            read saved_user
                                            echo -e "Do you want to specify a connection port ? [22 by default]"
                                            read saved_port
                                                if [[ $saved_port -ne "22" ]]
                                                    then
                                                    saved_port2=$saved_port
                                                    else
                                                    saved_port2="22"
                                                fi
                                            clear
                                            pinned
                                            echo -e "Do you want to save it ?"
                                            echo -e "(Type : [Y] for Yes [N] for No)"
                                            echo -e "$green---------------------------------------------"
                                            echo -e "Host:$saved_ip:$saved_port2"
                                            echo -e "User:$saved_user"
                                            echo -e "---------------------------------------------$endcol"
                                            read confirm
                                                if [[ "$confirm" =~ ^[y|Y]$ ]]
                                                    then
                                                    clear
                                                    pinned
                                                    echo -e "Give a name to your save :" 
                                                    read saved_name
                                                    echo -e "$saved_user ;  $saved_ip ; $saved_port " >> $saved_name.sft_pinned
                                                    gpg -c $saved_name.sft_pinned
                                                    rm $saved_name.sft_pinned
                                                    echo -e "$green Host successfully saved ! $endcol"
                                                    sleep 2
                                                    clear 
                                                    menu
                                                else
                                                clear
                                                menu
                                            fi
                                        else
                                        break
                                        fi
                                done
                                clear
                                menu
                            ;;

                            2)
                                clear
                                pinned
                            check_gpg=$( ls | find *gpg | awk -F . '{$NF=""; print $1}'  )
                            if [[ -z "$check_gpg" ]]
                            then
                            echo -e "You don't have pinned hosts"
                            clear
                            menu
                            else
                            echo -e "$check_gpg"
                            sleep 2
                            return_menu
                            fi
                            ;;

                            3)
                                clear
                                menu
                            ;;

                            *)
                                echo -e "$yellow BAD ENTRIE $endcol"
                                sleep 2
                                clear
                                menu
                            ;;
                        esac
                    ;;

                    5)
                    clear
                    exit 0
                    ;;

                    *)
                    echo -e "$yellow BAD ENTRIE $endcol"
                    sleep 2
                    clear
                    menu
                    ;;
                esac
    }
clear
menu
#EKIP
