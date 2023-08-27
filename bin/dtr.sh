#!/bin/sh

#    This file is part of dotfiles.
#    Copyright (C) 2020-2023  Emir Turkes
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

# Disable all third-party repos
    
sudo zypper mr -d spotify-easyrpm && i=$((i+1)) \
    && sudo zypper mr -d google-chrome && i=$((i+1)) \
    && sudo zypper mr -d skype-stable && i=$((i+1)) \
    && sudo zypper mr -d teams && i=$((i+1)) \
    && sudo zypper mr -d devel:languages:rust && i=$((i+1)) \
    && sudo zypper mr -d network:im:signal && i=$((i+1)) \
    && sudo zypper mr -d vscode && i=$((i+1)) \
    && sudo zypper mr -d home:sor593 && i=$((i+1)) \
    && sudo zypper mr -d nordvpn && i=$((i+1)) \
    && sudo zypper mr -d dvd && i=$((i+1)) \
    && sudo zypper mr -d games && i=$((i+1)) \
    && sudo zypper mr -d games:tools && i=$((i+1)) \
    && sudo zypper mr -d filesystems && i=$((i+1)) \
    && echo ${i} repos disabled
