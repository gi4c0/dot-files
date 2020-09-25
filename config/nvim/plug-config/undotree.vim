nnoremap <silent> <leader>u :UndotreeToggle<cr>:UndotreeFocus<cr>

" Persistent undo
if has("persistent_undo")
    set undodir=/home/alex/dev/.undodir
    set undofile
endif
