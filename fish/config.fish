
# fnm
set PATH $HOME/.fnm $HOME/bin /usr/local/go/bin $PATH/go/bin $PATH
set -gx EDITOR nvim
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

# Use custom config file to avoid loading it twice
set -gx RANGER_LOAD_DEFAULT_RC 'FALSE'

set -gx BROWSER (which google-chrome-stable)
fnm env --multi | source
