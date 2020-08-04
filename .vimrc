call has('python3')

call plug#begin()
" Project search (files, buffers, etc)
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" File tree
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'                   "Add functionality for surrounding stuff
Plug 'tpope/vim-repeat'                     "Enable repeating for surround
Plug 'bling/vim-airline'                    "Nice colorized status bar an the bottom

Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'

Plug 'tpope/vim-fugitive'                   "for git
Plug 'tpope/vim-unimpaired'                 "Adds shortcuts for fugitive (<[-q>, <[-Q>)
Plug 'scrooloose/nerdcommenter'             "Commenting tool

"Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Run :call coc#util#install()


Plug 'jiangmiao/auto-pairs'                 "Auto insert pairs for '{]
Plug 'sirver/ultisnips'                     "snippets
Plug 'airblade/vim-gitgutter'               "Show git diff

"Code hightlighting
Plug 'sheerun/vim-polyglot'               "One plugin for all languages

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'dag/vim-fish'                         "Support for .fish files
call plug#end()

" ----------- Native vim settings -----------
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


" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the last used search pattern.
" if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  " syntax on
" endif

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

" Scrolling stuff
"Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescroll=1
set sidescrolloff=15

"hightlighting search result
set hlsearch
"highlight everythign right after typing
set incsearch

set ignorecase "Ingore case while search
set showmatch "Show matching brackets
set history=200 "History amount of commands to keep in memory


" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
"===============================================

augroup AutoMake
  autocmd!

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  " Close vim is only nerd tree buffer left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  "typescript stuff
  " autocmd QuickFixCmdPost [^l]* nested cwindow
  " autocmd QuickFixCmdPost    l* nested lwindow
  " autocmd FileType go nnoremap <C-b> <Plug>(go-def)
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd FocusLost,WinLeave * :silent! wa
  " Trigger autoread when changing buffers or coming back to vim in terminal.
  autocmd FocusGained,BufEnter * :silent! !
augroup END


"---------------- COLOR SCHEME --------------//
let g:solarized_termcolors=256
let g:enable_bold_font = 1
let g:enable_italic_font = 1
colorscheme codedark
let g:airline_theme = 'codedark'
"--------------------------------------------//


" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "
" Wrap in try/catch to avoid errors on initial install before plugin is available
try
  " === Denite setup ==="
  " Use ripgrep for searching current directory for files
  " By default, ripgrep will respect rules in .gitignore
  "   --files: Print each file that would be searched (but don't search)
  "   --glob:  Include or exclues files for searching that match the given glob
  "            (aka ignore .git files)
  "

  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '--recurse-submodules', '-c', '--exclude-standard'])

  " Use ripgrep in place of 'grep'
  call denite#custom#var('grep', 'command', ['rg'])

  " Remove date from buffer list
  call denite#custom#var('buffer', 'date_format', '')
  " Custom options for ripgrep
  "   --vimgrep:  Show results with every match on it's own line
  "   --hidden:   Search hidden directories and files
  "   --heading:  Show the file name above clusters of matches from each file
  "   --S:        Search case insensitively if the pattern is all lowercase
  call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

  " Recommended defaults for ripgrep via Denite docs
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  " Custom options for Denite
  "   auto_resize             - Auto resize the Denite window height
  " automatically.
  "   prompt                  - Customize denite prompt
  "   direction               - Specify Denite window direction as directly
  " below current pane
  "   winminheight            - Specify min height for Denite window
  "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
  "   prompt_highlight        - Specify color of prompt
  "   highlight_matched_char  - Matched characters highlight
  "   highlight_matched_range - matched range highlight
  let s:denite_options = {'default' : {
        \ 'split': 'horizontal',
        \ 'start_filter': 1,
        \ 'auto_resize': 1,
        \ 'source_names': 'short',
        \ 'prompt': 'λ ',
        \ 'highlight_matched_char': 'QuickFixLine',
        \ 'highlight_matched_range': 'Visual',
        \ 'highlight_window_background': 'Visual',
        \ 'highlight_filter_background': 'DiffAdd',
        \ 'winrow': 1,
        \ 'vertical_preview': 1
        \ }}

  " Loop through denite options and enable them
  function! s:profile(opts) abort
    for l:fname in keys(a:opts)
      for l:dopt in keys(a:opts[l:fname])
        call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
      endfor
    endfor
  endfunction

  call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry



" ========== coc.nvim ========== "
" Highlight the symbol and its references when holding the cursor. 
" // TODO: maybe delete if causes performance issues
autocmd CursorHold * silent call CocActionAsync('highlight')



" NERDComments
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let NERDTreeKeepTreeInNewTab=1


" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


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
" Output path to current file/buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation

"TEST
"improve performance
set regexpengine=0


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   <leader>bb - Browser currently open buffers
"   <leader>ph - Browse list of files in current directory
"   <leader>/  - Search current directory for occurences of given term and close window if no results
"   <leader>*  - Search current directory for occurences of word under cursor
nnoremap <silent> <leader>bb :Denite buffer<CR>
nnoremap <silent> <leader>ph :DeniteProjectDir file/rec/git<CR>
nnoremap <silent> <leader>/ :<C-u>Denite grep:. -no-empty<CR>
nnoremap <silent> <leader>* :<C-u>DeniteCursorWord grep:.<CR>


" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction


" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-Space>
  \ denite#do_map('toggle_select').'j'
endfunction


" Delete current buffer
nnoremap <silent> <leader>bd :bdelete<cr>

" Save file
nnoremap <silent> <leader>fs :w<cr>

" Clear search
nnoremap <silent> <leader>sc :nohlsearch<CR>

" Map keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Map for rename current word
nmap <leader>mrr <Plug>(coc-rename)

" Open git status vertical from right side
nnoremap <silent> <leader>gs :vertical :Git<cr><C-w>L
" Git blame
nnoremap <silent> <leader>gb :Git blame<cr>

" locate current file in NERDTree or close if NERDTree tab is opened
function! NerdTreeToggleFind()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction

nnoremap <silent> <leader>pt :call NerdTreeToggleFind()<CR>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" better mark jumping
nnoremap ' `

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Show list of errors from current buffer
nmap <silent> <leader>el :CocDiagnostics<CR>
nmap <silent> <leader>eL :CocDiagnostics<CR>
