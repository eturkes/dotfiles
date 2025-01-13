#!/bin/sh

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

# Checks directory for files that lack a newline character 

# The following section is adapted from content on Stack Exchange 
# https://stackoverflow.com/questions/3261925/how-to-fix-no-newline-at-end-of-file-warning-for-lots-of-files
# Question asked by: Elliot 
# https://stackoverflow.com/users/103213/elliot
# Answer given by: Tim Abell 
# https://stackoverflow.com/users/10245/tim-abell
# START adapted content
for i in ./*(D); do \
    if diff /dev/null "$i" | tail -1 | grep '^\\ No newline' > /dev/null; then \
        echo $i; 
    fi; done
# END adapted content
