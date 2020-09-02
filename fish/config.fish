# fnm
set -gx EDITOR nvim
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

set -gx DENO_INSTALL "/home/alex/.deno"

set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"

set -gx PATH "$GOPATH/bin:$GOROOT/bin:$DENO_INSTALL/bin:$PATH"
