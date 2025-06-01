" If a hard to understand issue arises, remove h and l from this
set whichwrap+=<,>,[,],h,l
set backspace=indent,eol,start
set number
set relativenumber
set cursorline
set ignorecase
set smartcase
set wildmenu
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=10
set nofixeol
set ruler
set incsearch
set showmatch matchtime=3

filetype plugin indent on
syntax on


let mapleader = ","

imap <C-Del> <Esc>lce
imap <C-BS> <C-W>

nmap <C-Left> b
nmap <C-Right> w
nmap <F5> <Esc>:w<CR>:!python % [filename.py]; <CR>

" https://github.com/junegunn/vim-plug
" :PlugInstall
" :PlugUpdate

call plug#begin()

Plug 'https://github.com/joshdick/onedark.vim' 
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/frazrepo/vim-rainbow'
Plug 'https://github.com/JuliaEditorSupport/julia-vim'

Plug 'lervag/vimtex'

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

call plug#end()

au FileType cpp,py call rainbow#load()
let g:vimtex_syntax_conceal_disable = 1

silent! colorscheme onedark
