# fnm
set -gx EDITOR nvim

# Fixes weird error in nvim
set -x SHELL /bin/bash

# UNIX Pass: Defualt password length
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

set -Ua fish_user_paths /opt/homebrew/bin

# Required for golang
# set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"

set -gx PATH "$HOME/.bin:/opt/homebrew/opt/node@18/bin:/Users/alekseypanchenko/bin:/Users/alekseypanchenko/go/bin:/Users/alekseypanchenko/.cargo/bin:$PATH"

# Abbreviations
abbr --add wb cd /Users/alekseypanchenko/projects/crysberry/w-backend
abbr --add cry cd /Users/alekseypanchenko/projects/crysberry
abbr --add ct cargo nextest run
abbr --add ctn TRACE=1 cargo nextest run --no-capture --

zoxide init --cmd cd fish | source
