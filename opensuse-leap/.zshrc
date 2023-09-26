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

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

PS1='%F{${USER_LEVEL}}[%F{${COLOR_NORMAL}}%D{%T}%F{${USER_LEVEL}}]─$(_prompt_magicmace_status)[%F{${COLOR_NORMAL}}$(prompt-pwd)%F{${USER_LEVEL}}]${(e)git_info[prompt]}─>%f '

zstyle ':zim' disable-version-check yes

# From $HOME/.bashrc
export EDITOR=/usr/bin/nvim
test -s $HOME/.alias && . $HOME/.alias || true

# Choose man page automatically when there are multiple
export set MAN_POSIXLY_CORRECT=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/eturkes/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# From nvm installer
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add user npm packages to path
export PATH=~/.npm-global/bin:$PATH

# Add Foundry to path
export PATH="$PATH:/home/eturkes/.foundry/bin"

# Keep bin from dotfiles repo in separate symlink
export PATH="$PATH:/home/eturkes/bin-dotfiles"

# Stop Ksshaskpass from popping up when using Git
unset SSH_ASKPASS

#
# Functions
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
        && echo Upgrade npm and global packages: \
            && npm install --location=global npm@latest \
            && npm update --location-global \
        && echo Upgrade\ dotfiles: \
            && cd $HOME/Documents/projects/dotfiles/ \
            && git pull \
            && cd - \
        && echo Upgrade\ terminology-themes: \
            && cd $HOME/Documents/apps/terminology-themes/ \
            && git pull \
            && cd - \
        && echo Upgrade\ gitignore: \
            && cd $HOME/Documents/apps/gitignore/ \
            && git pull \
            && cd - \
        && echo Upgrade\ zimfw: \
            && zimfw update \
            && zimfw upgrade \
        && cd $HOME/Documents/apps/iso \
            && wget -N --trust-server-names=on \
            https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso \
            && cd -\
        && nvim +'call dein#update()' +qall \
        && dtr.sh \
        && sudo zypper up --details \
        && sudo zypper in --details https://zoom.us/client/latest/zoom_openSUSE_x86_64.rpm \
        && etr.sh \
        && sudo zypper up --details \
        && sudo zypper dup --details --from packman-essentials --allow-vendor-change \
        && sudo rpmconf -a \
        && sudo btrfs fi usage / \
        && sudo zypper pa --orphaned --unneeded \
        && sudo zypper ps
    fi
}

#
# Aliases
#

# cd to Downloads directory
alias dow='cd $HOME/Downloads/'

# cd to projects directory
alias pro='cd $HOME/Documents/projects/'

# cd to reference directory
alias ref='cd $HOME/Documents/reference/'

# cd to apps directory
alias app='cd $HOME/Documents/apps/'

# Use correct program in Git
alias vimdiff='nvim -d'

# ls with long listing, almost-all, and human-readable options
alias lah='ls -lAh'

# ls with long listing, almost-all, human-readable, and sorted by time options
alias lap='ls -lAhtr'

# ls with almost-all option
alias lal='ls -A'

# Shortcut to xdg-open
alias open='xdg-open'

# diff with color
alias diff='diff --color=auto'
