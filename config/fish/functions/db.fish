function db
    eval (ssh-agent -c)
    set current_dir $PWD

    set env "uat"

    if test $argv[1] = "prod"
        set env "prod"
    end

    cd ~/projects/connected2Fiber/ssh-tunnel

    ./pass.sh && "./b$env"

    cd $current_dir
end
