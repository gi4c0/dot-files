
# fnm
set PATH $HOME/.fnm $HOME/bin $PATH
set -gx EDITOR vim
set -gx PASSWORD_STORE_GENERATED_LENGTH 20
set -gx BROWSER (which google-chrome-stable)
fnm env --multi | source
