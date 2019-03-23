# Emacs restart
# Restarts daemon and launch emacs

function er
  emacsclient -e '(kill-emacs)'
  emacs --daemon
  emacsclient -nc
end
