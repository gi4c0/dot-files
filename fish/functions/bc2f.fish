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

  cd ~/projects/connected2Fiber/UserAuthentication
  pm2 start ecosystem.config.js --env production

  cd ~/projects/connected2Fiber/Network-Finder-API
  # npm run pm2:prod
  pm2 start ecosystem.config.js --env production

  cd ~/projects/connected2Fiber/Network-Finder-Bulk-API
  # npm run pm2:prod
  pm2 start ecosystem.config.js --env production

  cd ~/projects/connected2Fiber/AddressFormatAPI
  # npm run prod
  pm2 start ecosystem.config.js --env production

  cd ~/projects/connected2Fiber/StandardAddressAPI
  # npm run pm2:prod
  pm2 start ecosystem.config.js --env production

  cd $current_dir
  clear
  pm2 list
end
