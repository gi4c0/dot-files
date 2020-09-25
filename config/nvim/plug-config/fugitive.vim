" FUGITIVE
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P "Add to info to status line

" Open git status vertical from right side
nnoremap <silent> <leader>gs :vertical :Git<cr>
" Git blame
nnoremap <silent> <leader>gb :Git blame<cr>

nnoremap <silent> <leader>gt :0Gclog<cr>

augroup AutoMakes
  autocmd!
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
