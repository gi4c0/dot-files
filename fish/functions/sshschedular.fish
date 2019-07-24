function sshschedular
    set address prodscheduler01@tcwscheduler01prod.eastus.cloudapp.azure.com
    ssh -L 9189:192.168.89.21:9189 $address
end
