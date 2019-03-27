function sshdev
  set address denadmin@dendevu2.eastus.cloudapp.azure.com

  if count $argv > /dev/null
    ssh -L $argv[1]:localhost:$argv[1] $address
  else
    ssh $address
  end
end
