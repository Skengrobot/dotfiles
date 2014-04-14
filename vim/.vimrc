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
