# fnm
set PATH /home/alex/.fnm $PATH
fnm env --multi | source

set -gx EDITOR nvim
set -gx PASSWORD_STORE_GENERATED_LENGTH 20

# Use custom config file to avoid loading it twice
set -gx RANGER_LOAD_DEFAULT_RC 'FALSE'
