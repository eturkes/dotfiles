# Copyright 2018-2019 Emir Turkes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
