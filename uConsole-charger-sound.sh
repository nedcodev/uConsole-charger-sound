#!/bin/bash
# /usr/local/bin/charger-sound.sh

# Play sound while handling mute
play_sound() {
    MUTE_STATUS=$(amixer get Master | grep -o "\[on\]" | head -1)
    
    if [ -z "$MUTE_STATUS" ]; then
        amixer -q set Master unmute
        aplay -q "$1"
        amixer -q set Master mute
    else
        aplay -q "$1"
    fi
}

if [ "$1" = "connect" ]; then
    # Play connect sound
    play_sound /usr/share/sounds/charging.wav
elif [ "$1" = "disconnect" ]; then
    # Play disconnect sound
    play_sound /usr/share/sounds/discharging.wav
fi