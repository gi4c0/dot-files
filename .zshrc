source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# Tell Antigen that you're done.
antigen apply

export PATH=$HOME/bin:/usr/local/bin:$PATH:$GOPATH/bin:/usr/local/sbin

# Path to your oh-my-zsh installation.
export ZSH="/Users/alekseypanchenko/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

ENABLE_CORRECTION="true"

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

# Aliases
export GOPATH=/Users/alekseypanchenko/go

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}:${HOME}/scripts"
export PATH

alias rlq="rabbitmqctl list_queues"
alias python='python3'
alias redis-start='brew services start redis'
alias db-start='sudo mongod &'
alias cockroach-start="cockroach start --insecure --host=localhost"
alias testnet-start='geth --testnet --syncmode="light" --rpc --rpcapi db,eth,net,web3,personal --cache=1024 --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*"'
alias hm='cd /Users/alekseypanchenko/projects/hire-match/backend; nvm use 9;'
alias py='python3'
alias sshdev='ssh denadmin@dendevu2.eastus.cloudapp.azure.com'
alias sshprod='ssh denroot@denprdu1.eastus.cloudapp.azure.com'
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
