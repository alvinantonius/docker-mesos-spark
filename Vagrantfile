Vagrant.configure("2") do |config|
  config.vm.provision "docker"
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

  config.vm.define "master" do |master|
    master.vm.box = "centos/7"
    master.vm.hostname = 'master'
  end

  config.vm.define "slave1" do |slave1|
    slave1.vm.box = "centos/7"
    slave1.vm.hostname = 'slave1'
    slave1.vm.provider "virtualbox" do |slave1|
      slave1.memory = 4096
    end
  end

  config.vm.define "spark" do |spark|
    spark.vm.box = "centos/7"
    spark.vm.hostname = 'spark'
  end
end


