#!/bin/bash

case $1 in
  up)   brightnessctl set +5% ;;
  down) brightnessctl set 5%- ;;
esac

BRIGHT=$(brightnessctl get)
MAX=$(brightnessctl max)
PCT=$(( BRIGHT * 100 / MAX ))

dunstify -a "osd" -u low -r 9994 -h int:value:"$PCT" " Brightness: ${PCT}%"
