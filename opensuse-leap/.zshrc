#    This file is part of dotfiles.
#    Copyright (C) 2020-2022  Emir Turkes
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
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

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

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

PS1='%F{${COLOR_USER}}[%F{${COLOR_NORMAL}}%D{%T}%F{${COLOR_USER}}]─$(_prompt_magicmace_main)[%F{${COLOR_NORMAL}}$(prompt-pwd)%F{${COLOR_USER}}]${(e)git_info[prompt]}─>%f '

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

# Add user npm packages to path
export PATH=~/.npm-global/bin:$PATH

# Add Foundry to path
export PATH="$PATH:/home/eturkes/.foundry/bin"

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
        && conda deactivate \
    && echo Upgrade npm and global packages: \
        && npm install --location=global npm@latest \
        && npm update --location-global \
    && echo Upgrade\ dotfiles: \
        && cd $HOME/Documents/projects/dotfiles/ \
        && git pull \
        && cd - \
    && echo Upgrade\ gitignore: \
        && cd $HOME/Documents/apps/gitignore/ \
        && git pull \
        && git fetch upstream \
        && git merge upstream/master \
        && cd - \
    && echo Upgrade\ zimfw: \
        && zimfw update \
        && zimfw upgrade \
    && cd $HOME/Documents/apps/iso \
        && wget -N --trust-server-names=on \
        https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso \
        && cd -\
    && nvim +'call dein#update()' +qall \
    && dtr.sh && sudo zypper up --details \
    && etr.sh && sudo zypper up --details \
    && sudo zypper dup --details --from packman --allow-vendor-change \
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
