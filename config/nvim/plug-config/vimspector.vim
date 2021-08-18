let g:vimspector_install_gadgets = [ 'vscode-go' ]

nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>de :VimspectorReset<cr>

nnoremap <leader>dc :call win_gotoid(g:vimspector_session_windows.code)<CR>:MaximizerToggle<CR>
nnoremap <leader>dt :call win_gotoid(g:vimspector_session_windows.tagpage)<CR>:MaximizerToggle<CR>
nnoremap <leader>dv :call win_gotoid(g:vimspector_session_windows.variables)<CR>:MaximizerToggle<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart

nnoremap <leader>d<leader> :call vimspector#Continue()<CR>

nmap <leader>dr <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
