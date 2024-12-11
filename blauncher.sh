#!/bin/bash

trap 'continue' SIGINT

# Funzione per avviare le applicazioni
launch_app() {
  case $1 in
    "Firefox")
      nohup firefox & ;;
    "Kitty")
      nohup kitty & ;;
    "Thunar")
      nohup thunar & ;;
    "Gparted")
      nohup kitty -e sudo gparted & ;;
    *)
      echo "Applicazione sconosciuta";;
  esac
}

# Loop principale
while true; do
  # Uso di dialog per selezionare le applicazioni
  app=$(dialog --title "MENU" --menu "Scegli un'applicazione da avviare:" 15 50 4 \
    "Kitty" "Terminale" \
    "Firefox" "Browser" \
    "Thunar"  "File manager" \
    "Gparted"  "Partition manager" 3>&1 1>&2 2>&3)
  
  # Controlla se l'utente ha annullato l'operazione
  if [ $? -ne 0 ]; then
    continue
  fi
  
  # Avvia l'applicazione selezionata
  launch_app "$app"
  
  # Ritorna al menu dopo il lancio dell'app
  sleep 1
done

clear
exit 0
