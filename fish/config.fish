
# fnm
set PATH $HOME/.fnm $HOME/bin $PATH
set -gx EDITOR vim
set -gx BROWSER (which google-chrome-stable)
fnm env --multi | source
