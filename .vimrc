if v:progname =~? "evim"
  finish
endif

set nocompatible
set backspace=indent,eol,start
set history=50
set ruler

map Q gq
inoremap <C-U> <C-G>u<C-U>

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent
endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
              \ | wincmd p | diffthis
endif

" Pathogen
execute pathogen#infect()

" Custom settings
set encoding=utf-8
set scrolloff=3
set sidescrolloff=3
set showmode
set showcmd
set visualbell
set cursorline
set cursorcolumn
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set guioptions-=T
set foldmethod=manual

" Fix search
nnoremap / /\v
vnoremap / /\v
nnoremap <leader>\ :noh<CR>
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set iskeyword=@,48-57,_,192-255,-

" Some Navigation
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader><space> :ls<CR>

" Colors
colorscheme base16-default
set background=dark

if has('gui_running')
    " set guifont=DejaVu_Sans_Mono:h13:cANSI
    set guifont=DejaVu\ Sans\ Mono\ 13

    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>

endif

" Text wrapping
set nowrap
set colorcolumn=80

" Always show status line
set laststatus=2

" Default to unix newlines
set fileformat=unix
set fileformats=unix,dos

" Invisible characters (:set list)
set listchars=eol:↓,tab:→→,trail:·,precedes:<,extends:>

" Airline tabs
" let g:airline#extensions#tabline#enabled = 1

" Backups
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set viewdir=~/.vim/view

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" Indent Guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Syntastic
let g:syntastic_php_checkers = ['php']

" File types
au BufNewFile,BufRead *.tpl set filetype=php
au FileType php set omnifunc=phpcomplete#CompletePHP

" PHPDoc support
autocmd FileType php inoremap <C-Y> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-Y> :call PhpDocSingle()<CR>i
autocmd FileType php vnoremap <C-Y> :call PhpDocRange()<CR>i

