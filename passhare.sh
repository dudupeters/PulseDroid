#!/bin/sh

# Para descobrir qual device utilizar, "pactl list | grep Name"
# Acho que só testando pra saber qual deles é o correto

# Para ver se tudo deu certo...
#chmod 755 pashare
#./pashare start
#netstat -nlt | grep 8000 
#telnet 127.0.0.1 8000

# Aplicativo de reprodução para o android
# https://github.com/dudupeters/PulseDroid/blob/master/bin/PulseDroid.apk

case "$1" in
  start)
    $0 stop 
    pactl load-module module-simple-protocol-tcp rate=48000 format=s16le channels=2 source=alsa_output.pci-0000_00_1b.0.analog-stereo.monitor record=true port=8000
    ;;
  stop)
    pactl unload-module `pactl list | grep tcp -B1 | grep M | sed 's/[^0-9]//g'`
    ;;
  *)
    echo "Usage: $0 start|stop" >&2
    ;;
esac
