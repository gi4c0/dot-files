call has('python3')

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}           " Run :call coc#util#install()
  Plug 'kevinhwang91/rnvimr'                                " Ranger
  Plug 'rakr/vim-one'                                       " Theme
  Plug 'Th3Whit3Wolf/one-nvim'
  Plug 'tpope/vim-fugitive'                                 " for git
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-unimpaired'                               " Adds shortcuts for fugitive (<[-q>, <[-Q>)
  Plug 'scrooloose/nerdcommenter'                           " Commenting tool
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'                            " Nice checkout for git
  Plug 'tpope/vim-surround'                                 " Add functionality for surrounding stuff
  Plug 'tpope/vim-repeat'                                   " Enable repeating for surround
  Plug 'jiangmiao/auto-pairs'                               " Auto insert pairs for '{]
  Plug 'sirver/ultisnips'                                   " snippets
  Plug 'airblade/vim-gitgutter'                             " Show git diff
  Plug 'godlygeek/tabular'                                  " Auto tab alignment
  Plug 'dag/vim-fish'                                       " Support for .fish files
  Plug 'christoomey/vim-sort-motion'                        " For sorting with gs
  Plug 'mbbill/undotree'                                    " Kind of git but built in Vim
  Plug 'vimwiki/vimwiki'
  Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' } " Lazy git integration
  " Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'sheerun/vim-polyglot'                               " One plugin for all languages
  Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'
  " Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

" ----------- Native vim settings -----------
source $HOME/.dot-files/config/nvim/settings.vim
source $HOME/.dot-files/config/nvim/mappings.vim

" ----------- Scripts -----------------------
source $HOME/.dot-files/config/nvim/scripts/scripts.vim

" ===                           PLUGIN SETUP                               === "
source $HOME/.dot-files/config/nvim/plug-config/coc.vim
source $HOME/.dot-files/config/nvim/plug-config/ranger.vim
source $HOME/.dot-files/config/nvim/plug-config/markdown.vim
source $HOME/.dot-files/config/nvim/plug-config/fzf.vim
source $HOME/.dot-files/config/nvim/plug-config/fugitive.vim
source $HOME/.dot-files/config/nvim/plug-config/nerd-commenter.vim
source $HOME/.dot-files/config/nvim/plug-config/undotree.vim
source $HOME/.dot-files/config/nvim/plug-config/ultisnips.vim
source $HOME/.dot-files/config/nvim/plug-config/vim-wiki.vim
source $HOME/.dot-files/config/nvim/plug-config/git-gutter.vim
source $HOME/.dot-files/config/nvim/plug-config/tabularize.vim
source $HOME/.dot-files/config/nvim/plug-config/lazygit.vim
" source $HOME/.dot-files/config/nvim/plug-config/telescope.vim
" luafile $HOME/.dot-files/config/nvim/plug-config/tree-sitter.lua

" =========== Themes ============"
" source $HOME/.dot-files/config/nvim/themes/one.vim
" source $HOME/.dot-files/config/nvim/themes/one-nvim.vim
source $HOME/.dot-files/config/nvim/themes/nv-code.vim
