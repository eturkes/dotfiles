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

# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# From $HOME/.bashrc
export EDITOR=/usr/bin/nvim
test -s $HOME/.alias && . $HOME/.alias || true

# Choose man page automatically when there are multiple
export set MAN_POSIXLY_CORRECT=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/eturkes/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/eturkes/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/eturkes/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/eturkes/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#
# Functions
# Preferred over aliases to prevent conflicts with commands
#

# Upgrade system, clean up files, and check free space
function fup {
if command fup 2>/dev/null; then
    command fup
else
    echo Clean\ up\ Docker\ files: \
        && dsc.sh \
        && docker system prune -f \
    && echo Upgrade\ base\ conda\ environment: \
        && conda activate base \
        && cua.sh \
        && conda update conda \
        && conda deactivate \
    && echo Upgrade\ misc\ conda\ environment: \
        && conda activate misc \
        && cua.sh \
        && conda update youtube-dl \
        && pip install -U grip \
        && conda deactivate \
    && echo Upgrade\ dotfiles-eturkes: \
        && cd $HOME/Documents/projects/dotfiles-eturkes/ \
        && git pull \
        && cd - \
    && echo Upgrade\ tikz2pdf: \
        && cd $HOME/Documents/apps/tikz2pdf/ \
        && git pull \
        && cd - \
    && echo Upgrade\ btrfs-du: \
        && cd $HOME/Documents/apps/btrfs-du/ \
        && git pull \
        && cd - \
    && echo Upgrade\ scNetViz: \
        && cd $HOME/Documents/apps/scNetViz/ \
        && git pull \
        && cd - \
    && echo Upgrade\ wl-clipboard: \
        && cd $HOME/Documents/apps/wl-clipboard/ \
        && git pull \
        && cd - \
    && echo Upgrade\ systemd-swap: \
        && cd $HOME/Documents/apps/systemd-swap/ \
        && git pull \
        && cd - \
    && echo Upgrade\ terminology-themes: \
        && cd $HOME/Documents/apps/terminology-themes/ \
        && git pull \
        && cd - \
    && echo Upgrade\ gitignore-eturkes: \
        && cd $HOME/Documents/apps/gitignore-eturkes/ \
        && git pull \
        && git fetch upstream \
        && git merge upstream/master \
        && cd - \
    && echo Upgrade\ KeepToText-eturkes: \
        && cd $HOME/Documents/projects/KeepToText-eturkes/ \
        && git pull \
        && git fetch upstream \
        && git merge upstream/master \
        && cd - \
    && echo Upgrade\ zimfw-eturkes: \
        && cd $HOME/.zim/ \
        && git pull \
        && zmanage update \
        && git merge upstream/master \
        && cd - \
    && cd $HOME/Documents/apps/iso \
        && wget -N --trust-server-names=on \
        https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso \
        && cd -\
    && nvim +'call dein#update()' +qall \
    && dtr.sh && sudo zypper up --details \
    && etr.sh && sudo zypper up --details \
    && sudo zypper dup --details --from Packman\ Repository --allow-vendor-change \
    && sudo rpmconf -a \
    && sudo btrfs fi usage / \
    && sudo zypper pa --orphaned --unneeded \
    && sudo zypper ps
fi
}

# ls with long listing, almost-all, and human-readable options
function lah {
if command lah 2>/dev/null; then
    command lah
else
    ls -lAh
fi
}

# ls with almost-all option
function lal {
if command lal 2>/dev/null; then
    command lal
else
    ls -A
fi
}

# cd to Downloads directory
function dow {
if command dow 2>/dev/null; then
    command dow
else
    cd $HOME/Downloads/
fi
}

# cd to projects directory
function pro {
if command pro 2>/dev/null; then
    command pro
else
    cd $HOME/Documents/projects/
fi
}

# cd to reference directory
function ref {
if command ref 2>/dev/null; then
    command ref
else
    cd $HOME/Documents/reference/
fi
}

# cd to apps directory
function app {
if command app 2>/dev/null; then
    command app
else
    cd $HOME/Documents/apps/
fi
}

# cd to other directory
function oth {
if command oth 2>/dev/null; then
    command oth
else
    cd $HOME/Documents/other/
fi
}

#
# Aliases
# For things I want to deliberately override
#

alias vimdiff='nvim -d'
