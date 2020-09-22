let NERDTreeWinSize=45
let NERDTreeQuitOnOpen=3             " Close NERDTree window on selected file

let g:NERDDefaultAlign = 'left'
let NERDTreeKeepTreeInNewTab=1

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

" nnoremap <silent> <leader>pt :call NerdTreeToggleFind()<CR>

augroup myGroup
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END
