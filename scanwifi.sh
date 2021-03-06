#/bin/bash

# ESTE SCRIPT FARÁ UMA VARREDURA BUSCANDO TODO SINAL WIFI DA REGIÃO PRÓXIMA AO SEU COMPUTADOR.

# Made with a Raspberry Pi
# Author: Helio Giroto

IFS=$'\n'
clear

# Cabeçalho:
tput setab 1
tput setaf 7
echo " ====================================== "
echo " Escaneando as Internet's Wi-Fi da área "
echo " ====================================== "
tput sgr0
echo " "

# Criando os principais arquivos com o resultado da varredura:

date > wifis_regiao.txt

# para RPi:
# sudo iw wlan0 scan >> wifis_regiao.txt
# Para PC:
sudo iwlist wlp3s0 scan >> wifis_regiao.txt
# sendo que wlp3s0 acima, foi obtido com: ls -d /sys/class/net/w*


# Cria arquivos com os campos separados de cada um dos dados capturados acima:
# Para RPi:
#cat wifis_regiao.txt | grep 'SSID' | cut -d':' -f2 > ssid.wifi
#cat wifis_regiao.txt | grep 'signal' | cut -d':' -f2 > sinal.wifi


# Para PC:
# captura o nome das redes:
grep 'SSID' wifis_regiao.txt | cut -d':' -f2 > ssid.wifi
grep -i 'signal' wifis_regiao.txt | cut -d':' -f2 | cut -d'=' -f3 > sinal.wifi

> barras.wifi


# O laço abaixo cria as "barrinhas" gráficas para mostrar ao usuário quais são os roteadores com o sinal mais forte da região:
for item in $(cat sinal.wifi)
do
	freq=$(echo $item | cut -d' ' -f1)	
	#freq=$(echo $item | cut -d' ' -f1 | sed '/ //g')   # para RPi	
	# o nro de barras corresponde à qtde negativa - 100 (para ter o nro de qto falta para 100), pq qto menor o neg é melhor o sinal.
	barras=$(( (100 + $freq) /2 ))
	seq -s= $barras | tr -d '[:digit:]' >> barras.wifi
	
		# Abaixo não funcionou utilizando FOR com redirecionamento:
		# printf "%${barras}s" | sed 's/ /=/g';echo >> barras.wifi 	# Não funciona com laço + >>
		# printf '=%.0s' {1..10};echo >> barras.wifi

		# Fontes: 
		# https://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash
		# https://superuser.com/questions/86340/linux-command-to-repeat-a-string-n-times
done


# Cria arquivo final com seguintes dados: Nome do Roteador; sinal; barras gráficas.
paste -d';' ssid.wifi sinal.wifi barras.wifi> wifis.txt


# Apaga arquivos desnecessarios:
rm *.wifi


# Imprime na tela do usuário o resultado final :
awk -F';' '{printf "%-25s %-15s %s \n", $1, $2, $3}' wifis.txt
echo
