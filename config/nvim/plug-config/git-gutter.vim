" Disable default mappings
let g:gitgutter_map_keys = 0

" Jump to next git hunk
nmap <C-k> <Plug>(GitGutterPrevHunk)

" Jump to previous git hunk
nmap <C-j> <Plug>(GitGutterNextHunk)

nmap <leader>hs <Plug>(GitGutterPreviewHunk)
