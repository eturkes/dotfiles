"    This file is part of dotfiles.
"    Copyright (C) 2020-2022  Emir Turkes
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

" Syntax highlighting colors
colorscheme peachpuff
au colorscheme * hi MatchParen ctermbg=White ctermfg=Black
set nohlsearch

" Term title settings
set title
set titleold="Terminal"
set titlestring=%t

" Yank to clipboard
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Remember last cursor position 
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 &&
    \ line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Enable mouse support
set mouse=a

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('ajh17/VimCompletesMe')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('airblade/vim-gitgutter')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" vim-airline settings
let g:airline_theme='simple'

" vim-gitgutter settings
set updatetime=100
let g:gitgutter_override_sign_column_highlight=0
hi SignColumn ctermbg=None

" Readable highlighting
" Must be added at the end to work correctly
hi Visual cterm=reverse ctermbg=NONE
