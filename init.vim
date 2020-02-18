" Copyright 2018-2020 Emir Turkes
" 
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
" 
"     http://www.apache.org/licenses/LICENSE-2.0
" 
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

" Tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" Syntax highlighting colors
colorscheme peachpuff
au colorscheme * hi MatchParen ctermbg=White ctermfg=Black
set nohlsearch

" Term title settings
set title
set titleold="Terminal"
set titlestring=%t

" Set hybrid line numbers
set nu rnu
au colorscheme * hi LineNr ctermbg=Blue ctermfg=Black
au colorscheme * hi CursorLineNr ctermbg=None ctermfg=White

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

  " Add or remove your plugins here:
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('ajh17/VimCompletesMe')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('airblade/vim-gitgutter')

  " You can specify revision/branch/tag.

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
let g:gitgutter_override_sign_column_highlight = 0
hi SignColumn ctermbg=None

" Readable highlighting
" Must be added at the end to work correctly
hi Visual cterm=reverse ctermbg=NONE
