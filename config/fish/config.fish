# fnm
set -gx EDITOR nvim

# UNIX Pass: Defualt password length
set -gx PASSWORD_STORE_GENERATED_LENGTH 20
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORM wayland

# Required for golang
# set -gx GOROOT "/usr/local/go"
# set -gx GOPATH "$HOME/go"

# Add <Ctrl-r> key binding from fzf
fzf_key_bindings
