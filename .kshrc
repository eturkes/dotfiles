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

case "$-" in
*i*)	# we are interactive
	# we may have su'ed so reset these
	USER=$(id -un)
	UID=$(id -u)
	case $UID in
	0) PS1S='# ';;
	esac
	PS1S=${PS1S:-'$ '}
	HOSTNAME=${HOSTNAME:-$(uname -n)}
	HOST=${HOSTNAME%%.*}

	PROMPT="$USER:!$PS1S"
	#PROMPT="<$USER@$HOST:!>$PS1S"
	PPROMPT='$USER:$PWD:!'"$PS1S"
	#PPROMPT='<$USER@$HOST:$PWD:!>'"$PS1S"
	PS1=$PPROMPT
	# $TTY is the tty we logged in on,
	# $tty is that which we are in now (might by pty)
	tty=$(tty)
	tty=${tty##*/}
	TTY=${TTY:-$tty}
	# $console is the system console device
#	console=$(sysctl kern.consdev)
	console=${console#*=}

	case "$TERM" in
	sun*-s)
		# sun console with status line
		if [[ $tty != $console ]]; then
			# ilabel
			ILS='\033]L'; ILE='\033\\'
			# window title bar
			WLS='\033]l'; WLE='\033\\'
		fi
		;;
	xterm*)
		ILS='\033]1;'; ILE='\007'
		WLS='\033]2;'; WLE='\007'
		pgrep -xs $PPID telnet && export TERM=xterms
		;;
	*)	;;
	esac
	# do we want window decorations?
	if [[ -n $ILS ]]; then
		function ilabel { print -n "${ILS}$*${ILE}">/dev/tty; }
		function label { print -n "${WLS}$*${WLE}">/dev/tty; }

		alias stripe='label "$USER@$HOST ($tty) - $PWD"'
		alias istripe='ilabel "$USER@$HOST ($tty)"'

		# Run stuff through this to preserve the exit code
		function _ignore { local rc=$?; "$@"; return $rc; }

		function wftp { ilabel "ftp $*"; "ftp" "$@"; _ignore eval istripe; }

		function wcd     { \cd "$@";     _ignore eval stripe; }

		function wssh    { \ssh "$@";    _ignore eval 'istripe; stripe'; }
		function wtelnet { \telnet "$@"; _ignore eval 'istripe; stripe'; }
		function wsu     { \su "$@";     _ignore eval 'istripe; stripe'; }

		alias su=wsu
		alias cd=wcd
		alias ftp=wftp
		alias ssh=wssh
		alias telnet=wtelnet
		eval stripe
		eval istripe
		PS1=$PROMPT
	fi
;;
*)	# non-interactive
;;
esac

HISTFILE="$HOME/.ksh_history"
HISTSIZE=100000
HISTCONTROL=ingnoredups

export VISUAL="nvim"
export EDITOR="$VISUAL"

set -o emacs

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
