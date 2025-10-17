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
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

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
set title
set showcmd

filetype plugin indent on
syntax on

" Remember position when opening vim
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

inoremap {<CR> {<CR>}<Esc><<O
" inoremap ( ()<Esc>i
" inoremap () ()
" inoremap (<CR> (<CR>)<Esc><<O

let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

au FileType cpp,py call rainbow#load()
au FileType c,cpp set cinoptions=:4,l1

let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_view_method = 'zathura'
let mapleader = ","

silent! colorscheme onedark

" Register Python LSP
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" Register Python LSP
if executable('clangd')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'cpp'],
        \ })
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <leader>a :LspCodeAction<CR>
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" Autocomplete
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"


command! -nargs=? Run call Run(<f-args>)
function! Run(...)
    let l:path = findfile("run.sh", '.;')
    if l:path == ""
        echo "No run.sh found in parent directories"
        return
    endif
    let l:args = join(a:000, ' ')
    execute "!" l:path l:args
endfunction

nnoremap <F5> <Esc>:w<CR>:Run<CR>
