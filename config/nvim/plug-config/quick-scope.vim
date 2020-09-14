" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=021 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#FF0000' gui=underline ctermfg=202 cterm=underline
augroup END

let g:qs_max_chars=150

