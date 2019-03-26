function bc2f
  set current_dir $PWD
  pm2 delete all

  set env "UAT"
  if test $argv[1] = "prod"
    set env "PROD"
  end

  # systemctl start rabbitmq.service

  cd ~/projects/connected2Fiber/ssh-tunnel
  npm run $argv[1]
  pm2 delete "User Auth API $env:8092"
  pm2 delete "Standard Address API $env:8086"
  pm2 delete "Bulk Rabbit $env:5672"

  cd ~/projects/connected2Fiber/UserAuthentication
  npm run pm2:$argv[1]

  # cd ~/projects/connected2Fiber/International-Address-API
  # npm run pm2:$argv[1]

  cd ~/projects/connected2Fiber/Network-Finder-API
  npm run pm2:$argv[1]

  cd ~/projects/connected2Fiber/Network-Finder-Bulk-API
  npm run pm2:$argv[1]

  cd ~/projects/connected2Fiber/AddressFormatAPI
  npm run prod

  cd ~/projects/connected2Fiber/StandardAddressAPI
  npm run pm2:$argv[1]

  cd $current_dir
  clear
  pm2 list
end
