" equk.co.uk - vimrc file
" =======================

set encoding=utf-8
set nocompatible
autocmd! bufwritepost .vimrc source %

filetype plugin on
filetype plugin indent on
filetype on
syntax on

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let mapleader = "," " rebind <Leader> key
set wildmode=list:longest " allow TAB completion
set autoread " autoreload file on changes
set tags=~/.vim/tags/tags

set mouse=a
set bs=2 " backspace
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Display of cursor etc
set cursorline
set ruler
set autoindent
set smartindent

" code completion
set completeopt=menu

" use global system clipboard
set clipboard=unnamed

set history=700
set undolevels=700

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing
set number " show line numbes

set mouse-=a " disable visual mode on mouse select

" highlight whitespace
" ====================
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//

" Color scheme
" ============
set t_Co=256
color jellybeans
" set background to none for transparency
hi! Normal ctermbg=NONE guibg=NONE
set colorcolumn=80
highlight ColorColumn ctermbg=8

" Load vundle
" ===========
source ~/.vim/config/vundle.vim

" Load custom config files
" ========================
source ~/.vim/config/keymap.vim
source ~/.vim/config/plugins.vim
