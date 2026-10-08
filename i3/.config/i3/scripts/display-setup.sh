#!/bin/bash
# Auto-detect and configure connected displays
# Enables external display if connected, disables if not

displays=$(xrandr --query | grep " connected")

# Get primary and secondary displays
primary=$(echo "$displays" | head -1 | awk '{print $1}')
external=$(echo "$displays" | tail -1 | awk '{print $1}')

if [ -z "$primary" ]; then
    exit 1
fi

# If only one display, disable others
if [ "$primary" = "$external" ]; then
    xrandr --output "$primary" --auto
    xrandr --output HDMI-A-0 --off 2>/dev/null
    xrandr --output HDMI-A-1 --off 2>/dev/null
else
    # Multiple displays detected: enable both
    xrandr --output "$primary" --auto --primary
    xrandr --output "$external" --auto --right-of "$primary"
fi

# Reapply wallpaper to all displays
feh --bg-scale "$HOME/.local/share/wallpapers/the_climber_part_2.png" 2>/dev/null
