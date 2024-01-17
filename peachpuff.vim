"    This file is part of dotfiles.
"    Copyright (C) 2020-2024  Emir Turkes
"
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
"    Emir Turkes can be contacted at emir.turkes@eturkes.com

" Vim color file
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2003-04-23
" URL: http://trific.ath.cx/Ftp/vim/colors/peachpuff.vim

" This color scheme uses a peachpuff background (what you've expected when it's
" called peachpuff?).
"
" Note: Only GUI colors differ from default, on terminal it's just `light'.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "peachpuff"

hi Normal guibg=PeachPuff guifg=Black

hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
hi Directory term=bold ctermfg=4 guifg=Blue
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
hi Search term=reverse ctermbg=3 guibg=Gold2
hi MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
hi ModeMsg term=bold cterm=bold gui=bold
hi LineNr term=underline ctermfg=3 guifg=Red3
hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
hi WildMenu term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#e3c1a5
hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
hi DiffAdd term=bold ctermbg=4 guibg=White
hi DiffChange term=bold ctermbg=5 guibg=#edb5cd
hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#ff8060
hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4 guifg=#406090
hi Constant term=underline ctermfg=1 guifg=#c00058
hi Special term=bold ctermfg=5 guifg=SlateBlue
hi Identifier term=underline ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=3 gui=bold guifg=Brown
hi PreProc term=underline ctermfg=5 guifg=Magenta3
hi Type term=underline ctermfg=2 gui=bold guifg=SeaGreen
hi Ignore cterm=bold ctermfg=7 guifg=bg
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow

