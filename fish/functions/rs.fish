function rs
  if not set -q argv[1]
    echo "No id provided"
    return 1
  else if not set -q argv[2]
    echo "No env provided"
    return 1
  end


  pm2 delete $argv[1]
  npm run pm2:$argv[2]
end

