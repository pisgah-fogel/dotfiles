export _JAVA_AWT_WM_NONREPARENTING=1
xrandr --output HDMI-0 --mode 1920x1080
xinput set-prop 9 "libinput Accel Speed" 1.0
xinput set-button-map 9 1 4 3 2 8 6 7 5
exec dwm
