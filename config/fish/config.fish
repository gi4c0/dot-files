# fnm
set -gx EDITOR nvim

# UNIX Pass: Defualt password length
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

# Required for golang
# set -gx GOROOT "/usr/local/go"
# set -gx GOPATH "$HOME/go"

set -gx PATH "$HOME/.bin:/var/lib/snapd/snap/bin:/snap/bin:/home/alex/.cargo/bin:$PATH"

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx /home/alex/.dot-files/config/xinitrc -- -keeptty
    end
end

# Add <Ctrl-r> key binding from fzf
fzf_key_bindings
