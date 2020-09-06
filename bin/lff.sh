#!/bin/sh

#    This file is part of dotfiles.
#    Copyright (C) 2020  Emir Turkes
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

# List most fragmented files in home directory

# TODO: Fix error:
# find: ‘filefrag’ terminated by signal 13

sudo find $HOME -type f -exec filefrag {} + | awk '{print $(NF-2),$0}' | sort -rn \
    | cut -f2- -d ' ' | head
