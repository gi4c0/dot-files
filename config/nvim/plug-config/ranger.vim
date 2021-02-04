" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

nmap <silent> <leader>r :RnvimrToggle<CR>
nmap <silent> <leader>pt :RnvimrToggle<CR>

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Customize the initial layout
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.9 * &columns)),
            \ 'height': float2nr(round(0.9 * &lines)),
            \ 'col': float2nr(round(0.05 * &columns)),
            \ 'row': float2nr(round(0.05 * &lines)),
            \ 'style': 'minimal' }

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 40

let g:rnvimr_ranger_cmd = 'ranger --cmd="set colorscheme snow"'
