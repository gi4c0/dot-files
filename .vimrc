"No compatible mode (no compatible with VI)
set nocompatible

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'                   "Add functionality for surrounding stuff
Plug 'w0rp/ale'                             "Anynchronous lint engine
Plug 'bling/vim-airline'                    " Nice colorized status bar an the bottom

Plug 'altercation/vim-colors-solarized'     " Just a theme

Plug 'tpope/vim-fugitive'                   "for git
Plug 'scrooloose/nerdcommenter'             "Commenting tool

"Auto completion
Plug 'jiangmiao/auto-pairs'                 "Auto insert pairs for '{]
Plug 'valloric/youcompleteme'               " ./install.py --js-completer --go-completer. Needs python 3
"Plug 'ervandew/supertab'                    " use <Tab> for all your insert completion needs
Plug 'ctrlpvim/ctrlp.vim'                   "for searching files by <C-p>
Plug 'sirver/ultisnips'                     " snippets
Plug 'honza/vim-snippets'                   " for snippets too
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'               "Show git diff

"Code hightlighting
Plug 'fatih/vim-go'                         "For golang
Plug 'othree/yajs.vim'
"Plug 'pangloss/vim-javascript'              "Indentation and highlighting
Plug 'mxw/vim-jsx'
call plug#end()

"My vim settings
filetype plugin indent on
runtime macros/matchit.vim
set hidden

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

"----------------NerdTREE settings------------------//
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-d> :NERDTreeToggle<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
"locate current file in NERDTree
map <leader>l :NERDTreeFind<cr>
"close vim if only nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" NERDComments:
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let NERDTreeKeepTreeInNewTab=1
"==================================================//

set showcmd        "Show commands"
set ruler          "Show cursor position all the time"
set laststatus=2
set autowrite      "Automatically write before running commands
set autoread       "Reload files changed outside vim
set nocursorline
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

"Tabs and space
set tabstop=2
set expandtab
set shiftwidth=2
"set smarttab
set ai
set nu "Show number of lines
set relativenumber "reletive numbers of lines ;)

"HTML Editing
set matchpairs+=<:>

"========= Scrolling stuff ================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

"---------------- COLOR SCHEME --------------//
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"--------------------------------------------//

"Disable highlighting search result on Enter key
"nnoremap <silent> <cr> :nohlsearch<cr><cr>
set hlsearch
set incsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set ignorecase "Ingore case while search
set incsearch "Live search. Show pattern while typing
set showmatch "Show matching brackets
set history=200 "History amount of commands to keep in memory
"set path+=** "recursive search through files

"===============PLUGINS OPTIONS============================//

"------------------YouCompleteme---------------------//
set completeopt-=preview "Prevent opening new window with documentation
"===================================================//

"-------------------Highlighting options ----------------//
let g:ale_linters = {'javascript': ['eslint'], 'go': ['go build', 'gofmt', 'golint', 'gometalinter', 'gosimple', 'gotype', 'go vet', 'staticcheck']}
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
"----------------------------------------------------//

"----------------JS-VIM-------------------------
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
" jsx
let g:jsx_ext_required = 0
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
au FileType javascript.jsx nmap <C-b> :YcmCompleter GoToDefinition<CR>
"-----------------------------------------------//

" --------------Go Vim ----------------------//
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
"let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
"set shell=/bin/sh
au FileType go nmap <C-b> <Plug>(go-def)
"============================================//

"--------------- CtrlP------------------------//
"CtrlP
let g:ctrlp_working_path_mode = 'ra' " Detect root of project by nearest .git
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules     " Ingore node_modules.
"==========================================//

"--------------- UltiSnips ------------------//
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit="vertical" "for split window UltiSnipsEditSplit
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips'] " Provide directory for UltiSnips
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
"-----------------------------------------//

"=============== KEYMAP =========================
imap jj <Esc>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' "output path to current file/buffer

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks, because it's easier
"nnoremap <tab> %
"vnoremap <tab> %

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
"vnoremap <C-c> "*y

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Also map leader + s
" map <leader>s <C-S>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa
