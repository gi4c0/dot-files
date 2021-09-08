" Global extension names to install when they aren't installed.
let g:coc_global_extensions = [
  \ 'coc-json', 'coc-tsserver', 'coc-tslint-plugin', 'coc-rls', 'coc-format-json',
  \ 'coc-tslint', 'coc-spell-checker', 'coc-yaml', 'coc-sh', 'coc-fish', 'coc-go',
  \ 'coc-protobuf'
\]

" Menu -> JSON format
nnoremap <leader>mj :CocCommand formatJson --indent=2 --quote=" --trailing=false<CR>

" Scrolling in float window
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Map keys for goto's
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> gy <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Toggle menu of options on current line
vmap <silent> <C-Space> <Plug>(coc-codeaction-line)
" nmap <silent> <C-Space> <Plug>(coc-codeaction-line)

" Toggle menu of options on current word
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)

" Map for rename current word
nmap <silent> <leader>mrr <Plug>(coc-rename)

" Restart Coc server
nmap <silent> <leader>mrs :CocRestart<cr>

" Menu (Coc) Search
nmap <leader>ms :CocSearch 

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

" Use ctrl+k and ctrl+j to navigate diagnostics
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" Show list of errors from current buffer
nmap <silent> <leader>el :CocDiagnostics<CR>
nmap <silent> <leader>eL :CocDiagnostics<CR>

augroup cocGroup
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  " autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END
