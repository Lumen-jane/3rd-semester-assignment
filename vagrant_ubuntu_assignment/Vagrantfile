Vagrant.configure(2) do |config|
    
  # create the slave node
  config.vm.define "slave" do |slave01|
    slave01.vm.box = "ubuntu/focal64"
    slave01.vm.hostname = "Slave"
    slave01.vm.network "private_network", ip: "172.0.0.2"
    slave01.vm.boot_timeout = 600
    slave01.vm.provision "shell", path: "master.sh"
  end

  

  # create the loadbalancer
  config.vm.define "loadbal" do |loadbal01|
    loadbal01.vm.box = "ubuntu/focal64"
    loadbal01.vm.hostname = "loadbal"
    loadbal01.vm.network "private_network", ip: "192.168.56.5"
    loadbal01.vm.boot_timeout = 600
    loadbal01.vm.provision "shell", path: "loadbalancer.sh"
  end
end
