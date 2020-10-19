call has('python3')

call plug#begin()
  Plug 'scrooloose/nerdtree'                  " File tree
  Plug 'xuyuanp/nerdtree-git-plugin'
  Plug 'kevinhwang91/rnvimr'                  " Ranger
  Plug 'tpope/vim-surround'                   "Add functionality for surrounding stuff
  Plug 'tpope/vim-repeat'                     "Enable repeating for surround
  Plug 'bling/vim-airline'                    "Nice colorized status bar an the bottom

  Plug 'rakr/vim-one'
  Plug 'sainnhe/sonokai'

  Plug 'tpope/vim-fugitive'                   "for git
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'              " Nice checkout for git

  Plug 'tpope/vim-unimpaired'                 "Adds shortcuts for fugitive (<[-q>, <[-Q>)
  Plug 'scrooloose/nerdcommenter'             "Commenting tool

  "Auto completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Run :call coc#util#install()


  Plug 'jiangmiao/auto-pairs'                 "Auto insert pairs for '{]
  Plug 'sirver/ultisnips'                     "snippets
  Plug 'airblade/vim-gitgutter'               "Show git diff

  "Code hightlighting
  Plug 'sheerun/vim-polyglot'               "One plugin for all languages
  Plug 'jceb/vim-orgmode'

  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  Plug 'dag/vim-fish'                         "Support for .fish files
  Plug 'justinmk/vim-sneak'
  Plug 'ap/vim-css-color'
  Plug 'christoomey/vim-sort-motion'          " For sorting with gs
  Plug 'mbbill/undotree'                      " Kind of git but built in Vim
  " Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

" ----------- Native vim settings -----------
source $HOME/.dot-files/config/nvim/settings.vim
source $HOME/.dot-files/config/nvim/mappings.vim

" ===                           PLUGIN SETUP                               === "
source $HOME/.dot-files/config/nvim/plug-config/ultisnips.vim
source $HOME/.dot-files/config/nvim/plug-config/coc.vim
source $HOME/.dot-files/config/nvim/plug-config/fzf.vim
source $HOME/.dot-files/config/nvim/plug-config/fugitive.vim
source $HOME/.dot-files/config/nvim/plug-config/ranger.vim
source $HOME/.dot-files/config/nvim/plug-config/spelling.vim
source $HOME/.dot-files/config/nvim/plug-config/markdown.vim
source $HOME/.dot-files/config/nvim/plug-config/sneak.vim
source $HOME/.dot-files/config/nvim/plug-config/nerd-commenter.vim
source $HOME/.dot-files/config/nvim/plug-config/undotree.vim
" source $HOME/.dot-files/config/nvim/plug-config/tree-sitter.vim

" DISABLED
" source $HOME/.dot-files/config/nvim/plug-config/nerdtree.vim

" =========== Themes ============"
" source $HOME/.dot-files/config/nvim/themes/sonokai.vim
source $HOME/.dot-files/config/nvim/themes/one.vim
