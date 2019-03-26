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

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle -R; zle reset-prompt }
}

zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ? and / to perform backward and forward search in history
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

# Enable conda
. $HOME/miniconda3/etc/profile.d/conda.sh

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
        && dsc.sh && docker system prune -f \
    && echo Upgrade\ base\ conda\ environment: \
        && cua.sh \
        && conda update conda \
    && echo Upgrade\ misc\ conda\ environment: \
        && conda activate misc \
        && cua.sh \
        && conda update csvkit jupyter \
        && pip install -U grip youtube_dl \
        && conda deactivate \
    && echo Upgrade\ dotfiles-eturkes: \
        && cd $HOME/Documents/projects/dotfiles-eturkes/ \
        && git pull \
        && cd - \
    && echo Upgrade\ tikz2pdf: \
        && cd $HOME/Documents/apps/tikz2pdf/ \
        && git pull \
        && cd - \
    && echo Upgrade\ gitignore-eturkes: \
        && cd $HOME/Documents/apps/gitignore-eturkes/ \
        && git pull \
        && git fetch upstream && git merge upstream/master \
        && cd - \
    && echo Upgrade\ KeepToText-eturkes: \
        && cd $HOME/Documents/projects/KeepToText-eturkes/ \
        && git pull \
        && git fetch upstream && git merge upstream/master \
        && cd - \
    && echo Upgrade\ zimfw-eturkes: \
        && cd $HOME/.zim/ \
        && git pull \
        && zmanage update \
        && git fetch upstream && git merge upstream/master \
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
    && sudo btrfs fi usage / && lff.sh \
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
