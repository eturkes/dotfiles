#!/bin/sh

#    This file is part of dotfiles.
#    Copyright (C) 2020-2025  Emir Turkes
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#    Emir Turkes can be contacted at emir.turkes@eturkes.com

(conky | while read LINE; do xprop -root -set WM_NAME " $LINE"; done) &
xautolock -time 10 -locker slock &
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=xim
export XMODIFIERS=@im=fcitx
/usr/local/bin/mozc start
fcitx -r -d
sctd --latitude 39.89 --longitude 32.88 &
walland -s bing -b feh
dunst &
sndiod -f rsnd/1 -m play,mon
/usr/local/libexec/geoclue-2.0/demos/agent &
mkdir /tmp/chrome-home-cache
mkdir /tmp/firefox-home-cache
exec dbus-launch --exit-with-session dwm
