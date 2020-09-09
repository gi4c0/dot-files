" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

nmap <leader>r :RnvimrToggle<CR>

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Customize the initial layout
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.6 * &columns)),
            \ 'height': float2nr(round(0.6 * &lines)),
            \ 'col': float2nr(round(0.2 * &columns)),
            \ 'row': float2nr(round(0.2 * &lines)),
            \ 'style': 'minimal' }
