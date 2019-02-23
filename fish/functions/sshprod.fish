function sshprod
  if count $argv > /dev/null
    ssh -L $argv[1]:localhost:$argv[1] denroot@denprdu1.eastus.cloudapp.azure.com
  else 
    ssh denroot@denprdu1.eastus.cloudapp.azure.com
  end
end

