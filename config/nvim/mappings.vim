" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Delete current buffer
nnoremap <silent> <leader>bd :bdelete<cr>

nnoremap <silent> Q :bdelete<cr>

" Save file
nnoremap <silent> <leader>fs :w<cr>
nnoremap <silent> <C-s> :w<cr>

" Clear search
nnoremap <silent> <leader>sc :nohlsearch<CR>

" better mark jumping
nnoremap ' `

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Remap Y to yank till end of line
nnoremap Y y$

" Find and replace selected text with prompted
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Jump to notes
nnoremap <leader>on :e ~/notes.md<cr>

" Open vimrc
nnoremap <leader>fed :edit $MYVIMRC<CR>

" Output path to current file/buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" New tab with <C-t>
nnoremap <C-t> :tabedit<CR>

" Escape from terminal
tnoremap <C-g> <C-\><C-n>

" Change first word
nnoremap cI ^ciw
