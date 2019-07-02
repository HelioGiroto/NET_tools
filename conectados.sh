#!/bin/bash
# ESTE SCRIPT FARÁ QUE SE TOQUE UM BEEP QUANDO ALGUÉM MAIS ACESSAR A SUA INTERNET:
# ORIGINAL EM: https://github.com/HelioGiroto/NET_online

# Requer estes pacotes instalados:
# sudo apt-get install -y nmap hostname omxplayer

ips=$(hostname -I)
sliceIp=$(echo $ips | cut -d'.' -f 1,2,3)
echo "Conectados agora: "
nmap -sP $sliceIp.* | grep report | sed 's/Nmap scan report for//; 1d' 

# Watching your Net:
while :
do
	qtosAnterior=$(nmap -sP $sliceIp.* | grep report | sed 's/Nmap scan report for//; 1d' | wc -l)
	
	sleep 5m	# 5m = 5 minutos. Pode ser alterado esse tempo...
	qtosAgora=$(nmap -sP $sliceIp.* | grep report | sed 's/Nmap scan report for//; 1d' | wc -l)
	if [ $qtosAgora -gt $qtosAnterior ]	
	then
		echo; echo "Um novo usuário se conectou na sua Rede!!!"
		omxplayer beep.mp3			# Baixe em https://www.soundjay.com/beep-sounds-1.html
		nmap -sP $sliceIp.* | grep report | sed 's/Nmap scan report for//; 1d' 
		echo
	fi
done

# Autor: Helio Giroto
