"    This file is part of dotfiles.
"    Copyright (C) 2020-2023  Emir Turkes
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

" From Dein installer script
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/home/eturkes/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/home/eturkes/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('ConradIrwin/vim-bracketed-paste')
call dein#add('ajh17/VimCompletesMe')
call dein#add('sheerun/vim-polyglot')
call dein#add('airblade/vim-gitgutter')

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
"if dein#check_install()
" call dein#install()
"endif

" vim-airline settings
let g:airline_theme='simple'

" vim-gitgutter settings
set updatetime=100
let g:gitgutter_override_sign_column_highlight=0
hi SignColumn ctermbg=None

" Readable highlighting
" Must be added at the end to work correctly
hi Visual cterm=reverse ctermbg=NONE
