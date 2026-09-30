function nas --description "SSH to NAS and attach to tmux session (default: mac)"
    set -l session mac
    if set -q argv[1]
        set session $argv[1]
    end
    ssh nas@100.65.209.113 -t "tmux new -A -s $session"
end
