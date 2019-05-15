call has('python3')

call plug#begin()
    Plug 'scrooloose/nerdtree'
    Plug 'xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-surround'                   "Add functionality for surrounding stuff
    Plug 'bling/vim-airline'                    "Nice colorized status bar an the bottom

    Plug 'altercation/vim-colors-solarized'     "Just a theme
    Plug 'joshdick/onedark.vim'

    Plug 'tpope/vim-fugitive'                   "for git
    Plug 'tpope/vim-unimpaired'                 "Adds shortcuts for fugitive (<[-q>, <[-Q>)
    Plug 'tpope/vim-repeat'                     "Enable repeating for surround
    Plug 'scrooloose/nerdcommenter'             "Commenting tool

    "Auto completion
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'} " Run :call coc#util#install()


    Plug 'jiangmiao/auto-pairs'                 "Auto insert pairs for '{]
    " Plug 'valloric/youcompleteme'               " ./install.py --js-completer --go-completer. Needs python 2 or 3
    Plug 'flowtype/vim-flow'
    Plug 'ctrlpvim/ctrlp.vim'                   "for searching files by <C-p>
    Plug 'd11wtq/ctrlp_bdelete.vim'             "For deleting buffers by <C-2>
    Plug 'sirver/ultisnips'                     "snippets
    Plug 'mattn/emmet-vim'
    Plug 'airblade/vim-gitgutter'               "Show git diff

    "Code hightlighting
    Plug 'sheerun/vim-polyglot'                 "One plugin for all languages
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    Plug 'dag/vim-fish'                         "Support for .fish files
call plug#end()

" ----------- Native vim settings -----------
    runtime macros/matchit.vim
    set hidden

" Russion language
" set keymap=russian-jcukenwin
    set iminsert=0
    set imsearch=0
    highlight lCursor guifg=NONE guibg=Cyan
 "Включает русскую ё
" noremap <F6> :setlocal spell! spelllang=ru_yo,en_us<cr>


" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the last used search pattern.
    if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
      syntax on
    endif

"Show commands
    set showcmd
    set laststatus=2
"Automatically write before running commands
    set autowrite
"Reload files changed outside vim
    set autoread

"Tabs and space
    set tabstop=8
    set softtabstop=2
    set shiftwidth=2
    set expandtab
    set autoindent
    filetype plugin indent on
    set number relativenumber "reletive numbers of lines ;)

"HTML Editing
    set matchpairs+=<:>

" Scrolling stuff
"Start scrolling when we're 8 lines away from margins
    set scrolloff=8
    set sidescroll=1
    set sidescrolloff=15

"hightlighting search result
    set hlsearch
"highlight everythign right after typing
    set incsearch
"Disable hightlight for
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

    set ignorecase "Ingore case while search
    set incsearch "Live search. Show pattern while typing
    set showmatch "Show matching brackets
    set history=200 "History amount of commands to keep in memory
"===============================================

    augroup AutoMake
      autocmd!

      autocmd StdinReadPre * let s:std_in=1
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
      autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.scss
      autocmd FileType javascript.jsx nmap <C-b> :YcmCompleter GoToDefinition<CR>
      autocmd FileType html,css,javascript.jsx EmmetInstall
      "typescript stuff
      autocmd QuickFixCmdPost [^l]* nested cwindow
      autocmd QuickFixCmdPost    l* nested lwindow
      autocmd FileType go nnoremap <C-b> <Plug>(go-def)
      autocmd BufReadPost fugitive://* set bufhidden=delete
      autocmd FocusLost,WinLeave * :silent! wa
    " Trigger autoread when changing buffers or coming back to vim in terminal.
      autocmd FocusGained,BufEnter * :silent! !
    augroup END


"---------------- COLOR SCHEME --------------//
    let g:solarized_termcolors=256
    let g:enable_bold_font = 1
    let g:enable_italic_font = 1
    colorscheme onedark

    set background=dark
"--------------------------------------------//


"===============PLUGINS OPTIONS============================//

" Coc (autocompletion)
let g:coc_global_extensions = [ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml' ]

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)


"NerdTREE settings
    noremap <C-d> :NERDTreeToggle<CR>
    nnoremap <Leader>n <plug>NERDTreeTabsToggle<CR>
"locate current file in NERDTree
    nnoremap <leader>l :NERDTreeFind<cr>

" NERDComments:
    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    let g:NERDCommentEmptyLines = 1
    let g:NERDTrimTrailingWhitespace = 1
    let NERDTreeKeepTreeInNewTab=1



"YouCompleteme
    set completeopt-=preview "Prevent opening new window with documentation
    nnoremap <C-y> :YcmCompleter RestartServer<CR>

"Highlighting options
    let g:ale_linters = {'javascript': ['eslint'], 'go': ['go build', 'gofmt', 'golint', 'gometalinter', 'gosimple', 'gotype', 'go vet', 'staticcheck'], 'python': ['flake8', 'mypy', 'pylint'], 'typescript': ['tslint', 'tsserver', 'typecheck'] }
    let g:ale_sign_error = '⤫'
    let g:ale_sign_warning = '⚠'
" Enable integration with airline.
    let g:airline#extensions#ale#enabled = 1

"JS-VIM
    let g:javascript_plugin_jsdoc = 1
    let g:javascript_plugin_ngdoc = 1
" jsx
    let g:jsx_ext_required = 0
    let g:user_emmet_settings = {
    \  'javascript' : {
    \      'extends' : 'jsx',
    \  },
    \}

"Vue.js
    let g:vue_disable_pre_processors=1

" Python
    let g:ycm_python_binary_path = 'python3.6'

"Go Vim
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_types = 1
    let g:go_fmt_command = "goimports"



"CtrlP
    let g:ctrlp_working_path_mode = 'ra' " Detect root of project by nearest .git
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " Exclude files in .gitignore
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules     " Ingore node_modules.
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_follow_symlinks = 1
    let g:ctrlp_types = ['buf', 'fil']

"init plugin for deleting buffer
    call ctrlp_bdelete#init()

" UltiSnips
    let g:UltiSnipsUsePythonVersion = 3
    let g:UltiSnipsEditSplit="vertical" "for split window UltiSnipsEditSplit
    let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips'] " Provide directory for UltiSnips
" UltiSnips triggering
    let g:UltiSnipsExpandTrigger = '<C-j>'
    let g:UltiSnipsJumpForwardTrigger = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-k>'



"FUGITIVE
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P "Add to infor to status line


"=============== KEYMAP =========================
    cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' "output path to current file/buffer
    let mapleader=" "

" Navigate properly when lines are wrapped
    nnoremap j gj
    nnoremap k gk

" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
    set pastetoggle=<F2> "F2 before pasting to preserve indentation

" resize panes
    nnoremap <silent> <Right> :vertical resize +5<cr>
    nnoremap <silent> <Left> :vertical resize -5<cr>
    nnoremap <silent> <Up> :resize +5<cr>
    nnoremap <silent> <Down> :resize -5<cr>

" better mark jumping
    nnoremap ' `

" Save whenever switching windows or leaving vim.
"Save file

    nnoremap <C-F> :Ggrep -F '

"TEST
"improve performance
    set regexpengine=1
