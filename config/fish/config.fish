# fnm
set -gx EDITOR nvim

# Fixes weird error in nvim
set -x SHELL /bin/bash

# UNIX Pass: Defualt password length
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

set -Ua fish_user_paths /opt/homebrew/bin

# Required for golang
# set -gx GOROOT "/usr/local/go"
# set -gx GOPATH "$HOME/go"

set -gx PATH "$HOME/.bin:/opt/homebrew/opt/node@16/bin:$PATH"

# Add <Ctrl-r> key binding from fzf
# fzf_key_bindings
