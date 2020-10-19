augroup myGroup
  " Highlight the symbol and its references when holding the cursor. 
  " // TODO: maybe delete if causes performance issues
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Global extension names to install when they aren't installed.
let g:coc_global_extensions = [
  \ 'coc-json', 'coc-tsserver', 'coc-tslint-plugin',
  \ 'coc-tslint', 'coc-spell-checker', 'coc-yaml'
\]

" Map keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Map for rename current word
nmap <leader>mrr <Plug>(coc-rename)

" Rename file/imports
nmap <silent> <leader>mrf :CocCommand workspace.renameCurrentFile<CR>

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
