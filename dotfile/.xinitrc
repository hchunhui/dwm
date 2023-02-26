# input method
# export LANG="eo.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx #--panel=/usr/local/bin/ibus-ui

# auto start
killall goldendict
killall sz-button
killall footswitch
goldendict &
/home/hch/work/tp-button/sz-button &
/home/hch/work/footswitch/footswitch &

# X defaults
xrdb ~/.Xdefaults

# touch pad
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient VertEdgeScroll=0
synclient HorizTwoFingerScroll=1
synclient PalmDetect=1
synclient PalmMinWidth=10
synclient PalmMinZ=50

# screen output
#xrandr --output eDP-1 --gamma 0.75:0.75:0.75
#xrandr --output HDMI1 --off
#xrandr --output eDP1 --auto
#xrandr --output eDP1 --off
#xrandr --output HDMI1 --auto
xrandr --output eDP-1 --auto
xrandr --output HDMI-1 --left-of eDP-1 --auto --mode 1920x1080
xrandr --output DP-1 --left-of HDMI-1 --auto

#xgamma -rgamma 1.0 -ggamma 0.9 -bgamma 0.8

# wallpaper
#feh --bg-fill /usr/share/backgrounds/gnome/Stones.jpg
feh --bg-fill ~/Downloads/Blind_monks_examining_an_elephant.jpg

# keynav
killall keynav
keynav &

killall dunst
dunst &

killall polkit-gnome-authentication-agent-1
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

killall udiskie
udiskie --tray --no-notify --no-automount &

# space2ctrl
# /home/hch/work/Space2Ctrl/s2cctl start

# start dwm
dwm-statusbar &
mv /tmp/dwm.log /tmp/dwm.log.old
COLORTERM=truecolor dwm > /tmp/dwm.log 2>&1
