# fnm
set -gx EDITOR nvim
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"

set -gx PATH "$GOPATH/bin:$GOROOT/bin:$DENO_INSTALL/bin:$HOME/bin:$PATH"

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx /home/alex/.dot-files/config/xinitrc -- -keeptty
    end
end
