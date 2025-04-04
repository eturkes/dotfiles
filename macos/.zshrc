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

export CLICOLOR=1
alias ls="ls -G"

PS1=%F{green}"%n@%m%f %1~ %# "

export EDITOR=nvim
export VISUAL=nvim

source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use correct program in Git
alias vimdiff='nvim -d'

# Use fzf to cd into a dir or parent dir of a file
if ! command -v cdz >/dev/null 2>&1; then
  cdz() {
    dir="$(fd | fzf)"
    if [[ -f "$dir" ]]; then
      dir="$(dirname "$dir")"
    fi
    cd "$dir"
  }
fi
