# Script for startup all the services required for work

function bc2f
  # Check if rabbitmq is already running, if not -> stat it
  if ! systemctl is-active --quiet rabbitmq.service
      echo "RabbitMQ is inactive. Starting up..."
      sudo systemctl start rabbitmq.service
  end

  # Set current dir to var to be able to return ther after script is
  # finished
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
  npm run pm2:prod

  # cd ~/projects/connected2Fiber/International-Address-API
  # npm run pm2:$argv[1]

  cd ~/projects/connected2Fiber/Network-Finder-API
  npm run pm2:prod

  cd ~/projects/connected2Fiber/Network-Finder-Bulk-API
  npm run pm2:prod

  cd ~/projects/connected2Fiber/AddressFormatAPI
  npm run prod

  cd ~/projects/connected2Fiber/StandardAddressAPI
  npm run pm2:prod

  cd $current_dir
  clear
  pm2 list
end
