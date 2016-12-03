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
Plugin 'https://github.com/kien/ctrlp.vim.git'

" Vim-clang-format plugin (support auto-styling)
Plugin 'rhysd/vim-clang-format'

" Solarized colour scheme
Bundle 'jwhitley/vim-colors-solarized'
" Bundle 'altercation/vim-colors-solarized'

" Automatically comment sections of code
"Plugin 'scrooloose/nerdcommenter'

" Syntax errors in c++
Plugin 'scrooloose/syntastic'

" Set marks and get to them
"Plugin 'kshenoy/vim-signature.git'

" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Vim git-gutter plugin for showing changes realtime.
" Use <leader>h[s|u|r|p]
"   s - hunk stage, u - hunk unstage, r - hunk revert, p - hunk preview
Plugin 'airblade/vim-gitgutter'

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

set wildmenu " Turn on enhance mode in VIM command line (inc auto complete)
set ignorecase " ignore case when searching for patters
set smartcase " override ignorecase if upper case letters present

" Indenting
set expandtab
"set tabstop=4
set shiftwidth=2
set softtabstop=2
set nopaste
set autoindent smartindent
set smarttab
set backspace=eol,start,indent
set hlsearch
hi Search cterm=NONE ctermfg=gray ctermbg=184
set clipboard=unnamed
" Remove trailing whitespace when writing some filetypes
autocmd FileType c,cpp,java,py autocmd BufWritePre <buffer> :%s/\s\+$//e

set nostartofline
set confirm " dialog asks if you want to save changes instead of error
set wrap " wrap lines off screen to next line
set number " enable line numbers
set relativenumber
set ruler " show column and row number of cursor
set cmdheight=2 " height of command window
set nobackup " no darn tmp files
set nowb " no write backup
set noswapfile " no swap file
set autoread
set scrolloff=4
set laststatus=2

" For solarized plugin (color scheme)
" https://github.com/altercation/vim-colors-solarized
hi SignColumn ctermbg=Black
syntax enable
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
" Visual mode colour override for solarized.
highlight Visual cterm=NONE ctermbg=DarkBlue ctermfg=LightCyan guibg=Grey40

" Syntastic settings
let g:syntastic_cpp_compiler_options = ' -std=c++11 -Wall -Werror -Wextra'
let g:syntastic_check_on_open = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1

" Airline settings
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" batch indent thing
vmap > >gv
vmap < <gv

" sexy highlight everything between delimiters
noremap * %lv%%h
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" set line at 80-char column
set colorcolumn=80
hi StatusLine ctermbg=White ctermfg=Black

" Clang-format with the google style guide.
" options are #[llvm|google(default)|chromium|mozilla]
" let g:clang_format#google
" In normal mode, this shortcut will format the whole buffer!
" nnoremap <C-K> :ClangFormat<CR>
vnoremap <C-K> :ClangFormat<CR>

" Vim gitgutter should not update realtime.
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_signs = 0
let g:gitgutter_max_signs = 1000  " Max signs to display in a file

" Make me think CtrlP is Command-T
let g:ctrlp_map = '<leader>t'
