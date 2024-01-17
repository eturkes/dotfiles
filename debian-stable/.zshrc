#    This file is part of dotfiles.
#    Copyright (C) 2020-2024  Emir Turkes
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

#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# From $HOME/.bashrc
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#
# Functions
# Preferred over aliases to prevent conflicts with commands
#

# Create pre/post ZFS snapshot
# Usage: vzs VM_NAME
function vzs {
if command vzs 2>/dev/null; then
    command vzs
else
    sudo zfs destroy tank/$1@boot-pre \
    && sudo zfs rename tank/$1@boot-post tank/$1@boot-pre \
    && sudo zfs snapshot tank/$1@boot-post
fi
} 

# Create pre/post ZFS snapshot with apt update/upgrade
function aus {
if command aus 2>/dev/null; then
    command aus
else
    sudo apt update \
    && sudo zfs destroy tank/ROOT/debian@upgrade-pre \
    && sudo zfs destroy tank/var@upgrade-pre \
    && sudo zfs destroy tank/home@upgrade-pre \
    && sudo zfs snapshot tank/ROOT/debian@upgrade-pre \
    && sudo zfs snapshot tank/var@upgrade-pre \
    && sudo zfs snapshot tank/home@upgrade-pre \
    && sudo apt upgrade
fi
}

function fup {
if command fup 2>/dev/null; then
    command fup
else
    echo Upgrade\ zimfw-eturkes: \
        && cd $HOME/.zim/ \
        && git pull \
        && zmanage update \
        && git merge upstream/master \
        && cd - \
    && vim +PluginInstall! +qall \
    && aus
fi
}

#
# PATH
#

# Python
export PATH="$HOME/.local/bin:$PATH"
