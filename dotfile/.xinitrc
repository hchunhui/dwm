# input method
# export LANG="eo.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export XMODIFIERS="@im=fcitx"
export XIM=fcitx
export XIM_PROGRAM=fcitx
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
killall fcitx
fcitx &


# auto start
killall stardict
killall tp-button
killall footswitch
pkill -f proxy.py
stardict &
/home/hch/work/tp-button/tp-button &
/home/hch/work/footswitch/footswitch &
/home/hch/work/goagent-goagent-5558ae2/local/proxy.py &


# X defaults
xrdb ~/.Xdefaults


# touch pad
## Acer
#synclient TapButton1=1
#synclient TapButton2=2
#synclient TapButton3=3
#synclient VertEdgeScroll=1

## Thinkpad E440
# 1 finger = left click, 2 finger = right click, 3 finger = middle click
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0
synclient ClickFinger1=1
synclient ClickFinger2=3
synclient ClickFinger3=2
# enable horizontal two-finger scrolling (vertical is enabled by default)
synclient HorizTwoFingerScroll=1
# disable the top edge of the touchpad to prevent jittering when using the trackpoint
synclient AreaTopEdge=2500
# configure trackpoint buttons
synclient RightButtonAreaLeft=3700
synclient RightButtonAreaRight=4790
synclient RightButtonAreaTop=1550
synclient RightButtonAreaBottom=2000
synclient MiddleButtonAreaLeft=2900
synclient MiddleButtonAreaRight=3500
synclient MiddleButtonAreaTop=1550
synclient MiddleButtonAreaBottom=2000


# screen output
#xrandr --output HDMI1 --off
#xrandr --output eDP1 --auto
#xrandr --output eDP1 --off
#xrandr --output HDMI1 --auto
xrandr --output eDP1 --auto
xrandr --output VGA1 --right-of eDP1 --auto
xrandr --output HDMI1 --right-of VGA1 --auto

xgamma -rgamma 1.0 -ggamma 0.9 -bgamma 0.8

# wallpaper
feh --bg-fill /usr/share/backgrounds/gnome/Stones.jpg

# keynav
killall keynav
keynav &

# space2ctrl
# /home/hch/work/Space2Ctrl/s2cctl start

# start dwm
dwm-statusbar &
dwm > /tmp/dwm.log 2>&1
