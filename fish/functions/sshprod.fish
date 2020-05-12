function sshprod
  if count $argv > /dev/null
      ssh -L $argv[1]:localhost:$argv[1] prodweb01@tcwprodweb01.eastus.cloudapp.azure.com
  else
      ssh prodweb01@tcwprodweb01.eastus.cloudapp.azure.com
  end
end
