# /etc/udev/rules.d/99-charger-sound.rules

# Rule for when charger is connected
SUBSYSTEM=="power_supply", ATTR{online}=="1", ACTION=="change", \
    RUN+="/usr/local/bin/charging.sh connect"

# Rule for when charger is disconnected
SUBSYSTEM=="power_supply", ATTR{online}=="0", ACTION=="change", \
    RUN+="/usr/local/bin/discharging.sh disconnect"