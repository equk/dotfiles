set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" load plugins
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'fatih/vim-go'
Bundle 'rust-lang/rust.vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'pangloss/vim-javascript'
Bundle 'airblade/vim-gitgutter'
Bundle 'Yggdroot/indentLine'
Bundle 'elzr/vim-json'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'cespare/vim-toml'
Bundle 'stephpy/vim-yaml'
Bundle 'mxw/vim-jsx'
Bundle 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
