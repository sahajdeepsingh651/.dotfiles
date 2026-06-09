#!/bin/bash

case $1 in
  up)   wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
  down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP '\d+\.\d+' | awk '{printf "%d", $1 * 100}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

if [ "$MUTED" -gt 0 ]; then
  dunstify -a "osd" -u low -r 9993 -h int:value:0 " Muted"
else
  dunstify -a "osd" -u low -r 9993 -h int:value:"$VOL" " Volume: ${VOL}%"
fi
