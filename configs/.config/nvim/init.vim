" equilibriumuk neovim config
" ===========================
"
" https://github.com/equk/dotfiles

" Install Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'neomake/neomake', { 'for': ['rust', 'haskell', 'typescript'] }
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}


" FZF / Ctrlp for file navigation
" ===============================

if executable('fzf')
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname == "Darwin"
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf', {'dir': '~/.local/src/fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

" Language plugins
" ================

if executable('rustc')
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif

Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'vue'] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

call plug#end()

" appearance settings
" ===================

set t_Co=256
syntax on
set background=dark

" highlight whitespace
" ====================

" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//

" Color scheme
" ============

if (has('termguicolors'))
  set termguicolors
endif

" colorscheme jellybeans

colorscheme nightfly

" set background to none for transparency
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
" set colorcolumn=80
"highlight ColorColumn ctermbg=8 guibg=grey

" whitespace
highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL

" Undefined Marks
highlight UndefinedMarks ctermfg=yellow
autocmd Syntax * syn match UndefinedMarks /???/ containedin=ALL

au BufRead,BufNewFile *.conf          set filetype=dosini
au BufRead,BufNewFile *.bash*         set filetype=sh

set cursorline

" KEY MAPPING

" Leader key
let mapleader = ","

" j/k move virtual lines, gj/jk move physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Remap increment and decrement numbers to something that works on macs/linux
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" panes
nnoremap <leader>d :vsp<cr>
set splitright
nnoremap <leader>s :split<cr>
set splitbelow

" tabs
nnoremap <leader>] :tabn<cr>
nnoremap <leader>[ :tabp<cr>
nnoremap <leader>t :tabe<cr>

" Insert date
nnoremap <leader>fd "=strftime("%m-%d-%y")<CR>p

" Edit vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>evs :source $MYVIMRC<cr>

" Toggle paste with F2
set pastetoggle=<F2>

" Terminal Mode
" Use escape to go back to normal mode
tnoremap <Esc> <C-\><C-n>

set splitbelow

" indentation
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
filetype indent off

" Python indent
au BufNewFile,BufRead *.py
  \ setlocal tabstop=2
  \ shiftwidth=2
  \ softtabstop=2
  \ autoindent
  \ expandtab

" Golang indent
au BufNewFile,BufRead *.go
  \ setlocal tabstop=8
  \ shiftwidth=8
  \ softtabstop=8

" line numbers
set number

" show title
set title

" mouse
set mouse-=a

" utf-8 ftw
" nvim sets utf8 by default, wrap in if because prevents reloading vimrc
if !has('nvim')
  set encoding=utf-8
endif

" Ignore case unless use a capital in search (smartcase needs ignore set)
set ignorecase
set smartcase

" Textwidth for folding
set textwidth=100

" PLUGINS
" =======

" deoplete
" ========

let g:deoplete#enable_at_startup=1
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

call deoplete#custom#option('sources', {
	\ 'rust': ['racer'],
	\})

" NERDTree
" ========

" Open NERDTree in the dir of current file
function! NERDTreeToggleFind()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    execute ":NERDTreeClose"
  else
    execute ":NERDTreeFind"
  endif
endfunction

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <leader>c :call NERDTreeToggleFind()<cr>
nmap <C-n> :call NERDTreeToggleFind()<CR>

" Ripgrep for search
" ==================

if executable('rg')
  set grepprg=rg\ -i\ --vimgrep

  " Ripgrep on /
  command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  nnoremap <leader>/ :Rg<SPACE>
endif

" Airline
" =======

set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
"let g:airline#extensions#tabline#show_close_button = 0
"let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'


" lightline
" =========

let g:lightline = {
      \  'colorscheme': 'powerline',
      \  'active': {
      \    'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath', 'modified']],
      \  },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead',
      \ }
      \}

" FZF
" ===

let g:fzf_command_prefix = 'Fzf'
if executable('fzf')
  nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
  nmap <C-p> :FZF<cr>

  if executable('ag')
    " set fzf command to ag with gitignore support
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g "" .'
  endif

  if executable('rg')
    " set fzf command to ripgrep with gitignore support
    let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
    set grepprg=rg\ --vimgrep
  endif

else
  nnoremap <leader>v :CtrlP<Space><cr>
endif

" Racer
" =====

set hidden
let g:racer_experimental_completer = 1
au FileType rust nmap <leader>rx <Plug>(rust-doc)
au FileType rust nmap <leader>rd <Plug>(rust-def)
au FileType rust nmap <leader>rs <Plug>(rust-def-split)

" Neomake
" =======

let s:quitting = 0
au QuitPre *.rs let s:quitting = 1
au BufEnter *.rs let s:quitting = 0
au BufWritePost *.rs if ! s:quitting | Neomake | else | echom "Neomake disabled"| endif
au QuitPre *.ts let s:quitting = 1
au BufEnter *.ts let s:quitting = 0
au BufWritePost *.ts if ! s:quitting | Neomake | else | echom "Neomake disabled"| endif
let g:neomake_warning_sign = {'text': '?'}

" ALE
" ===

let g:airline#extensions#ale#enabled = 1
" let g:ale_linters = {'go': ['golint', 'gofmt']}
let g:ale_linters = {'rust': ['analyzer'], 'go': ['golint', 'gofmt'], 'javascript': ['eslint'],'CloudFormation' : ['cfn-lint']}
let g:ale_fixers = {'rust': ['rustfmt'], 'javascript': ['eslint'], 'json': ['jq']}
let g:ale_lint_delay = 800
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
"let g:ale_fixers = {'javascript': ['standard'], 'json': ['jq']}
"let g:ale_linters = {'javascript': ['standard'],'CloudFormation' : ['cfn-lint']}
let g:ale_sign_column_alwayus = 1
let g:ale_fix_on_save = 1

