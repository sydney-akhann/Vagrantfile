# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  #Forward mysql port
  #config.vm.network "forwarded_port", guest: 3306, host: 33060

  config.vm.network "private_network", ip: "192.168.2.41"
  config.vm.network "public_network", ip: "192.168.1.42"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.memory = "1024"
  end

  config.vm.synced_folder ".", "/vagrant", :nfs => true

  config.vm.synced_folder "../../Sites", "/vagrant/Sites", :nfs => true

end
