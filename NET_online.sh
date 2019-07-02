#!/bin/bash

###################################################
##  ASSIM QUE (O SINAL D)A INTERNET VOLTA        ## 
##      O ARQ. MP3 BEEP.MP3 TOCARÁ               ##
##                                               ##         
## Quando volte a Internet, tocará o despertador ##
##                                               ##               
##   RENOMEIE ALGUM ARQ DA SUA PREFERÊNCIA       ##
##              PARA beep.mp3                    ##
##                                               ##
##          * Requer VLC instalado               ##
##        (se não: sudo apt install vlc)         ##
###################################################

while :
do 
  ping -c 1 www.google.com &> /dev/null 
  [ $? -eq 0 ] && cvlc --play-and-exit beep.mp3 || echo NADA
  
  # NO MAC substitua a linha acima por esta abaixo:
  # [ $? -eq 0 ] && afplay beep.mp3 || echo NADA

  # No Raspberry Pi, use:
  # [ $? -eq 0 ] && omxplayer beep.mp3 || echo NADA


  sleep 3
done

# Author: Helio Giroto
# Made with a Raspberry Pi - https://www.facebook.com/RPi.br/
