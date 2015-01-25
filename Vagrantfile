# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

params = YAML.load_file 'parameters.yml'

Vagrant.configure(2) do |config|
  siteDir = params['php55']['site_dir']
  privateIp = params['php55']['private_ip']
  publicIp = params['php55']['public_ip']

  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

  config.vm.network "private_network", ip: privateIp
  config.vm.network "public_network", ip: publicIp

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site_php55.pp"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.memory = "1024"
  end

  config.vm.synced_folder ".", "/vagrant", :nfs => true

  config.vm.synced_folder siteDir, "/home/vagrant/Sites", :nfs => true
end
