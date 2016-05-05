set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'git://git.wincent.com/command-t.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on " Enable syntax highlighting
set wildmenu " Turn on enhance mode in VIM command line (inc auto complete)
set ignorecase " ignore case when searching for patters
set smartcase " override ignorecase if upper case letters present

" Indenting
set noexpandtab " dont use spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set paste
set autoindent smartindent
set smarttab
set backspace=eol,start,indent 

set nostartofline 
set confirm " dialog asks if you want to save changes instead of error
set wrap " wrap lines off screen to next line
set number " enable line numbers
set ruler " show column and row number of cursor
set cmdheight=2 " height of command window
set nobackup " no darn tmp files
set nowb " no write backup
set noswapfile " no swap file
set autoread
set scrolloff=4
set laststatus=2

" batch indent thing
vmap > >gv
vmap < <gv

" sexy highlight everything between delimiters
noremap * %lv%%h
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE 

" set line at 80-char column
set colorcolumn=80
