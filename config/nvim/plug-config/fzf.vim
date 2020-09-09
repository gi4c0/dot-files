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

" ============ Fzf ===================
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Check out branch
nnoremap <leader>gc :GBranches<CR>

" Search word under the cursor in project
nnoremap <leader>* yiw:Rg <C-r>0<CR>

" Search visually selected word in project
vnoremap <leader>* y:Rg <C-r>0<CR>

