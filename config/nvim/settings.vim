let mapleader=" "
runtime macros/matchit.vim
set hidden

" Russion language
" set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
"Включает русскую ё
" noremap <F6> :setlocal spell! spelllang=ru_yo,en_us<cr>

" Show commands
set showcmd
set laststatus=2
" Automatically write before running commands
set autowrite
" Reload files changed outside vim
set autoread

" Tabs and space
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set autoindent                          " Good auto indent
set smartindent                         " Makes indenting smart
filetype plugin indent on
set number relativenumber

" Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescroll=1
set sidescrolloff=15

" Hightlighting search result
set hlsearch
" Highlight everythign right after typing
set incsearch

set ignorecase "Ingore case while search
set showmatch "Show matching brackets
set history=200 "History amount of commands to keep in memory


" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
set timeoutlen=300                      " By default timeoutlen is 1000 ms
" Don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show signcolumns
set signcolumn=yes

" for the dark version
set background=dark

set nowrap                              " Display long lines
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set cursorline                          " Enable highlighting of the current line
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set clipboard=unnamedplus               " Copy paste between vim and everything else
