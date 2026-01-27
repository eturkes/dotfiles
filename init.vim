"    This file is part of dotfiles.
"    Copyright (C) 2020-2025  Emir Turkes
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

" Tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" Set hybrid line numbers
set nu rnu
au colorscheme * hi LineNr ctermbg=Blue ctermfg=Black
au colorscheme * hi CursorLineNr ctermbg=None ctermfg=White

highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

" Syntax highlighting colors
colorscheme peachpuff
set notermguicolors
set nohlsearch

hi Constant   cterm=None ctermfg=Green
hi Identifier cterm=None ctermfg=White
hi Function   cterm=None ctermfg=White
"hi Statement  cterm=None ctermfg=White
hi PreProc    cterm=None ctermfg=White
hi Type       cterm=None ctermfg=White
hi Special    cterm=None ctermfg=White
hi Delimiter  cterm=None ctermfg=White

" Term title settings
set title
set titleold="Terminal"
set titlestring=%t

" Yank to clipboard
set clipboard=unnamedplus

" Remember last cursor position 
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 &&
    \ line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Enable mouse support
set mouse=a

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax enable

" vim-airline settings
let g:airline_theme='owo'

" vim-gitgutter settings
set updatetime=100
let g:gitgutter_override_sign_column_highlight=0
hi SignColumn ctermbg=None

" Readable highlighting
" Must be added at the end to work correctly
hi Visual cterm=reverse ctermbg=None
