# If running from tty1 start sway
set TTY1 (tty)
if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
  set -gx GTK_THEME Arc-Dark
  set -gx EDITOR nvim

  set -gx PASSWORD_STORE_GENERATED_LENGTH 20
  set -gx MOZ_ENABLE_WAYLAND 1
  set -gx QT_QPA_PLATFORM wayland

  # output clip selection to stdout
  set -gx CM_OUTPUT_CLIP 1
  exec sway
end
