# Statusbar loop
#while true; do
#   xsetroot -name "$( date +"%F %R" )"
#   sleep 5s    # Update time every minute
#done &

# start menubar
dwmstatus 2>&1 >/dev/null &

# blueman
blueman-applet &

exec dwm
