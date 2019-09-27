# Script for short searching with 'ps -aux'

function f --argument-names 'search_term'
    if ! test -n "$search_term"
        echo "Error: Empty argument"
        return 1
    end

    ps -aux | grep "$search_term" | awk '{print $2,$11}'
    return 0
end
