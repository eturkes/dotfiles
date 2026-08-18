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

# pnpm's global shims, where `pnpm add -g` places them while PNPM_HOME stays unset; pnpm refuses a
# global install outright when this directory is off PATH.
case ":${PATH:-}:" in
    *":$HOME/.local/share/pnpm/bin:"*) ;;
    *) PATH="${PATH:+$PATH:}$HOME/.local/share/pnpm/bin" ;;
esac

# MoonBit's user-global toolchain, installed and self-updated under ~/.moon.
case ":${PATH:-}:" in
    *":$HOME/.moon/bin:"*) ;;
    *) PATH="${PATH:+$PATH:}$HOME/.moon/bin" ;;
esac
export PATH

mkdir -p -- /tmp/browser-os-home-cache

# Route file contents to Claude Code's Read tool. Sourced straight from the
# agents checkout, so a pull there is the whole update path, and sourced here so
# the head/tail guards land in the login shell Claude Code snapshots for every
# Bash call; the functions gate themselves on CLAUDECODE, so a human shell is
# unaffected.
if [ -r "$HOME/Projects/agents/claude/read-guard.sh" ]; then
    . "$HOME/Projects/agents/claude/read-guard.sh"
fi
