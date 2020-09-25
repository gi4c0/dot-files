let mapleader=" "
runtime macros/matchit.vim
set hidden


" set keymap=russian-jcukenwin          " Russion language
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" noremap <F6> :setlocal spell! spelllang=ru_yo,en_us<cr>   " Enable russion 'ё'

set showcmd                             " Show commands
set laststatus=2                        " influences when the last window will have a status line (2 - always)
set autowrite                           " Automatically write before running commands
set autoread                            " Reload files changed outside vim
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set autoindent                          " Good auto indent
set smartindent                         " Makes indenting smart
filetype plugin indent on
set number relativenumber
set scrolloff=8                         " Start scrolling when we're 8 lines away from margins
set sidescroll=1
set sidescrolloff=15
set hlsearch                            " Hightlighting search result
set incsearch                           " Highlight everything right after typing
set ignorecase                          " Ingore case while search
set showmatch                           " Show matching brackets
set history=200                         " History amount of commands to keep in memory
set cmdheight=2                         " Better display for messages
set updatetime=300                      " Smaller updatetime for CursorHold & CursorHoldI
set timeoutlen=1000                     " By default timeoutlen is 1000 ms
set shortmess+=c                        " Don't give |ins-completion-menu| messages.
set signcolumn=yes                      " Always show signcolumns
set background=dark                     " for the dark version
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

set nocompatible
filetype plugin on
syntax on


if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Put all autocmd commands here to avoid performance issues
augroup AutoMake
  autocmd!

  autocmd StdinReadPre * let s:std_in=1
  autocmd FocusLost,WinLeave * :silent! wa
  " Trigger autoread when changing buffers or coming back to vim in terminal.
  autocmd FocusGained,BufEnter * :silent! !

augroup END
