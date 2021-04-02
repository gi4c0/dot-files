" Disable default key mappings
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_close = 1

nmap <Leader>ba <Plug>BookmarkToggle
nmap <Leader>be <Plug>BookmarkAnnotate
nmap <Leader>bb <Plug>BookmarkShowAll
nmap <Leader>bn <Plug>BookmarkNext
nmap <Leader>bp <Plug>BookmarkPrev
nmap <Leader>bc <Plug>BookmarkClear
nmap <Leader>bk <Plug>BookmarkMoveUp
nmap <Leader>bj <Plug>BookmarkMoveDown
nmap <Leader>bg <Plug>BookmarkMoveToLine

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
