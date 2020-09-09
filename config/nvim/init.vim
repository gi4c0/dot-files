call has('python3')

call plug#begin()
" File tree
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'                   "Add functionality for surrounding stuff
Plug 'tpope/vim-repeat'                     "Enable repeating for surround
Plug 'bling/vim-airline'                    "Nice colorized status bar an the bottom

Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'rakr/vim-one'

Plug 'tpope/vim-fugitive'                   "for git
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'              " Nice checkout for git

Plug 'tpope/vim-unimpaired'                 "Adds shortcuts for fugitive (<[-q>, <[-Q>)
Plug 'scrooloose/nerdcommenter'             "Commenting tool

"Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Run :call coc#util#install()


Plug 'jiangmiao/auto-pairs'                 "Auto insert pairs for '{]
Plug 'sirver/ultisnips'                     "snippets
Plug 'airblade/vim-gitgutter'               "Show git diff

"Code hightlighting
Plug 'sheerun/vim-polyglot'               "One plugin for all languages
Plug 'jceb/vim-orgmode'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'dag/vim-fish'                         "Support for .fish files
Plug 'easymotion/vim-easymotion'
call plug#end()

" ----------- Native vim settings -----------
source $HOME/.dot-files/config/nvim/settings.vim

" Put all autocmd commands here to avoid performance issues
augroup AutoMake
  autocmd!

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd FocusLost,WinLeave * :silent! wa
  " Trigger autoread when changing buffers or coming back to vim in terminal.
  autocmd FocusGained,BufEnter * :silent! !

  " Highlight the symbol and its references when holding the cursor. 
  " // TODO: maybe delete if causes performance issues
  autocmd CursorHold * silent call CocActionAsync('highlight')


"---------------- COLOR SCHEME --------------//
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


colorscheme one
let g:airline_theme = 'one'
"--------------------------------------------//


" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "
"
" ========== coc.nvim ========== "
let NERDTreeWinSize=45
let NERDTreeQuitOnOpen=3


" ============ NERDComments ============== "
" Add <n> spaces before comment
let g:NERDSpaceDelims = 1

let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let NERDTreeKeepTreeInNewTab=1


" =========== UltiSnips =============== ""
let g:UltiSnipsUsePythonVersion = 3
" For split window UltiSnipsEditSplit
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.dot-files/UltiSnips', 'UltiSnips'] " Provide directory for UltiSnips

" FUGITIVE
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P "Add to info to status line

" ============ Fzf ===================
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'


"=============== KEYMAP =========================
" Output path to current file/buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation

"TEST
"improve performance
set regexpengine=0


" ============================================================================ "
" ===                             Jump to File                             === "
" ============================================================================ "
" Jump to notes
nnoremap <leader>on :e ~/notes.org<cr>

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "
" Show list of buffers
nnoremap <silent> <leader>bb :Buffers<CR>

" File history
nnoremap <silent> <leader>fr :History<CR>

" Search through the project
nnoremap <silent> <leader>/ :Rg<space>

" Show list of files
nnoremap <silent> <leader>ph :GFiles<CR>

" Git (history) commits
nnoremap <silent> <leader>ghh :Commits<CR>

" Git (history) commits for buffer
nnoremap <silent> <leader>ghb :BCommits<CR>

" Delete current buffer
nnoremap <silent> <leader>bd :bdelete<cr>

" Save file
nnoremap <silent> <leader>fs :w<cr>

" Clear search
nnoremap <silent> <leader>sc :nohlsearch<CR>

" Map keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Map for rename current word
nmap <leader>mrr <Plug>(coc-rename)

" Open git status vertical from right side
nnoremap <silent> <leader>gs :vertical :Git<cr><C-w>L
" Git blame
nnoremap <silent> <leader>gb :Git blame<cr>

" Check out branch
nnoremap <leader>gc :GBranches<CR>

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

" Rename file/imports
nmap <silent> <leader>mrf :CocCommand workspace.renameCurrentFile<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Remap Y to yank till end of line
nnoremap Y y$

" Find and replace selected text with prompted
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

map <Leader>j <Plug>(easymotion-prefix)

" Search word under the cursor in project
nnoremap <leader>* yiw:Rg <C-r>0<CR>

" Search visually selected word in project
vnoremap <leader>* y:Rg <C-r>0<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Open vimrc
nnoremap <leader>fed :edit $MYVIMRC<CR>
