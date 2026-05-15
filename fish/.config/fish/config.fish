if status is-interactive
    # Commands to run in interactive sessions can go here
end

fzf_configure_bindings # Enable fish key bindings
set --universal nvm_default_version v20.19.4
nvm use default > /dev/null

abbr -a v vim
abbr -a c clear
abbr -a y yazi

abbr -a k kubectl
abbr -a kc kubectl config
abbr -a kcu kubectl config use-context
abbr -a dev2 kubectl port-forward mysql-stage-0 3307:3306 -n infra-stage
abbr -a p pnpm
abbr -a gw git worktree
abbr -a fucksecurity NODE_TLS_REJECT_UNAUTHORIZED=0
abbr -a gpo git push origin 

zoxide init --cmd cd fish | source

# Theme for tokyo night
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2e3c64 \
  --color=bg:#1f2335 \
  --color=border:#29a4bd \
  --color=fg:#c0caf5 \
  --color=gutter:#1f2335 \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#29a4bd \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
# starship init fish | source
source "$HOME/.cargo/env.fish"

source "$HOME/.cargo/env.fish"
fish_add_path $HOME/.local/bin

source ~/dev/.env.fish

# fish_config theme choose catppuccin-macchiato
