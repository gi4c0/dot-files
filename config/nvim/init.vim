call has('python3')

call plug#begin()
  Plug 'kevinhwang91/rnvimr'                                " Ranger
  Plug 'tpope/vim-fugitive'                                 " for git
  Plug 'tpope/vim-unimpaired'                               " Adds shortcuts for fugitive (<[-q>, <[-Q>)
  Plug 'scrooloose/nerdcommenter'                           " Commenting tool
  Plug 'tpope/vim-surround'                                 " Add functionality for surrounding stuff
  Plug 'tpope/vim-repeat'                                   " Enable repeating for surround
  Plug 'jiangmiao/auto-pairs'                               " Auto insert pairs for '{]
  Plug 'sirver/ultisnips'                                   " snippets
  Plug 'airblade/vim-gitgutter'                             " Show git diff
  Plug 'dag/vim-fish'                                       " Support for .fish files
  Plug 'mbbill/undotree'                                    " Kind of git but built in Vim
  Plug 'vimwiki/vimwiki'
  Plug 'kdheepak/lazygit.nvim'                              " Lazy git integration

  " Themes related
  Plug 'navarasu/onedark.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': '0.5-compat'}
  Plug 'ChristianChiarulli/nvcode-color-schemes.vim'

  " Plug 'neoclide/coc.nvim', {'branch': 'release'}           " Run :call coc#util#install()
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils' " npm i -g eslint_d
  Plug 'glepnir/lspsaga.nvim'
  Plug 'ray-x/lsp_signature.nvim'

  " Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  " Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

  Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer'

  Plug 'nvim-lua/popup.nvim'                                " Required for telescope
  Plug 'nvim-lua/plenary.nvim'                              " Required for telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'                       " Required for lualine above

  Plug 'mtth/scratch.vim'
call plug#end()

" ----------- Native vim settings -----------
source $HOME/.dot-files/config/nvim/settings.vim
source $HOME/.dot-files/config/nvim/mappings.vim

" ----------- Scripts -----------------------
source $HOME/.dot-files/config/nvim/scripts/scripts.vim

" ===                           PLUGIN SETUP                               === "
" source $HOME/.dot-files/config/nvim/plug-config/coc.vim
source $HOME/.dot-files/config/nvim/plug-config/ranger.vim
source $HOME/.dot-files/config/nvim/plug-config/markdown.vim
source $HOME/.dot-files/config/nvim/plug-config/fugitive.vim
source $HOME/.dot-files/config/nvim/plug-config/nerd-commenter.vim
source $HOME/.dot-files/config/nvim/plug-config/undotree.vim
source $HOME/.dot-files/config/nvim/plug-config/ultisnips.vim
source $HOME/.dot-files/config/nvim/plug-config/vim-wiki.vim
source $HOME/.dot-files/config/nvim/plug-config/git-gutter.vim
source $HOME/.dot-files/config/nvim/plug-config/lazygit.vim
source $HOME/.dot-files/config/nvim/plug-config/scratch.vim

source $HOME/.dot-files/config/nvim/plug-config/vim-maximizer.vim
source $HOME/.dot-files/config/nvim/plug-config/vimspector.vim

source $HOME/.dot-files/config/nvim/plug-config/telescope.vim
luafile $HOME/.dot-files/config/nvim/plug-config/tree-sitter.lua
luafile $HOME/.dot-files/config/nvim/plug-config/lualine.lua

" LSP
source $HOME/.dot-files/config/nvim/plug-config/lsp-config.vim
luafile $HOME/.dot-files/config/nvim/plug-config/lsp-servers.lua
luafile $HOME/.dot-files/config/nvim/plug-config/compe-config.lua
luafile $HOME/.dot-files/config/nvim/plug-config/nvim-lsp-ts-utils.lua
luafile $HOME/.dot-files/config/nvim/plug-config/lsp-saga.lua
luafile $HOME/.dot-files/config/nvim/plug-config/lsp-signature.lua

" =========== Themes ============"
source $HOME/.dot-files/config/nvim/themes/one-dark.vim
" source $HOME/.dot-files/config/nvim/themes/nv-code.vim
