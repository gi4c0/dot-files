export PATH=$HOME/bin:/usr/local/bin:$PATH:$GOPATH/bin:/usr/local/sbin
export GOPATH=$HOME/go

# Path to your oh-my-zsh installation.
export ZSH="/Users/alekseypanchenko/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  brew
  node
  npm
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}:${HOME}/scripts"
export PATH

alias python='python3'
alias redis-start='brew services start redis'
alias db-start='sudo mongod &'
alias cockroach-start="cockroach start --insecure --host=localhost"
alias testnet-start='geth --testnet --syncmode="light" --rpc --rpcapi db,eth,net,web3,personal --cache=1024 --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*"'
alias hm='cd /Users/alekseypanchenko/projects/hire-match/backend; nvm use 9;'
alias py='python3'
alias sshdev='ssh denadmin@dendevu2.eastus.cloudapp.azure.com'
alias sshprod='ssh denroot@denprdu1.eastus.cloudapp.azure.com'
alias getPassword='cd ~/dev/decrypt; getPassword'
# alias rename_ts=`find . -name "*.t1" -exec bash -c 'mv "$1" "${1%.t1}".t2' - '{}'\;`

# IP Addresses
export hirematch="www@167.99.248.125"
export c2f_prod="denroot@denprdu1.eastus.cloudapp.azure.com"
export c2f_dev="denadmin@dendevu2.eastus.cloudapp.azure.com"

[[ -s "/Users/alekseypanchenko/.gvm/scripts/gvm" ]] && source "/Users/alekseypanchenko/.gvm/scripts/gvm"

# python env
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/3.6/bin/python3
export WORKON_HOME=$HOME/.virtualenvs   # Optional
export PROJECT_HOME=$HOME/py_projects      # Optional
source /Library/Frameworks/Python.framework/Versions/3.6/bin/virtualenvwrapper.sh

# direnv
eval "$(direnv hook zsh)"
