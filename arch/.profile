#    This file is part of dotfiles.
#    Copyright (C) 2020-2026  Emir Turkes
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

# Shared login environment for Bash, Zsh, and the desktop session.
export EDITOR=/usr/bin/nvim

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

case ":${PATH:-}:" in
    *":$HOME/.local/bin:"*) ;;
    *) PATH="$HOME/.local/bin${PATH:+:$PATH}" ;;
esac

case ":${PATH:-}:" in
    *":$HOME/.spicetify:"*) ;;
    *) PATH="${PATH:+$PATH:}$HOME/.spicetify" ;;
esac
export PATH

mkdir -p -- /tmp/browser-os-home-cache

# Route file contents to Claude Code's Read tool. Sourced here so the head/tail
# guards land in the login shell Claude Code snapshots for every Bash call; the
# functions gate themselves on CLAUDECODE, so a human shell is unaffected.
[ -r "$HOME/.claude/read-guard.sh" ] && . "$HOME/.claude/read-guard.sh"
