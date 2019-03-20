function bc2f
  set current_dir $PWD
  pm2 delete all

  cd ~/projects/connected2Fiber/ssh-tunnel
  npm start
  pm2 delete "MySQL UAT"

  cd ~/projects/connected2fiber/UserAuthentication
  npm run pm2:$argv[1]

  cd ~/projects/connected2Fiber/International-Address-API
  npm run pm2:$argv[1]

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

