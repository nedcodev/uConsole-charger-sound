# uConsole Charging Sound Notifications
A simple script that plays notification sounds when connecting or disconnecting the USB-C charger.

## Instructions 

### Create the notification script

```sh
sudo nano /usr/local/bin/uConsole-charger-sound.sh
```

#### Copy and paste the following code:
```sh
#!/bin/bash
# /usr/local/bin/uConsole-charger-sound.sh

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
```

### Make the script executable

```
sudo chmod +x /usr/local/bin/uConsole-charger-sound.sh
```

### Create the udev rule

``` bash
sudo nano /etc/udev/rules.d/99-uConsole-charger-sound.rules
```

#### Copy and paste the following rules:

```bash
# /etc/udev/rules.d/99-uConsole-charger-sound.rules

# Charger is connected
SUBSYSTEM=="power_supply", ATTR{online}=="1", ACTION=="change", \
    RUN+="/usr/local/bin/uConsole-charger-sound.sh connect"

# Charger is disconnected
SUBSYSTEM=="power_supply", ATTR{online}=="0", ACTION=="change", \
    RUN+="/usr/local/bin/uConsole-charger-sound.sh disconnect"
```

## Dependencies

- ALSA sound system (package ``alsa-utils``)
- udev (typically pre-installed)

## What is uConsole?
The uConsole by Clockwork Pi is a compact, modular handheld Linux computer designed for developers, hackers, and retro computing enthusiasts.


## License
Distributed under the MIT License. See ``LICENSE`` for more information.
