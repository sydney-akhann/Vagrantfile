# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

params = YAML.load_file 'parameters.yml'

Vagrant.configure(2) do |config|
  config.vm.define 'php55', primary: true do |php55|
    siteDir = params['php55']['site_dir']
    privateIp = params['php55']['private_ip']
    publicIp = params['php55']['public_ip']

    php55.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

    php55.vm.network "private_network", ip: privateIp
    php55.vm.network "public_network", ip: publicIp

    php55.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site_php55.pp"
    end

    php55.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.memory = "1024"
    end

    php55.vm.synced_folder ".", "/vagrant", :nfs => true
    php55.vm.synced_folder siteDir, "/home/vagrant/Sites", :nfs => true
  end

  config.vm.define 'php53', autostart: false do |php53|
    php53.vm.box = "puppetlabs/ubuntu-12.04-32-puppet"

    php53.vm.network "public_network", ip: "192.168.1.44", auto_config: false
    php53.vm.network "private_network", ip: "192.168.2.3", auto_config: false

    php53.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site_php53.pp"
    end

    php53.vm.provider "virtualbox" do |vb|
      #vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.memory = "1024"
      vb.gui = true
    end

    php53.vm.synced_folder ".", "/vagrant", :nfs => true
    php53.vm.synced_folder "~/Sites", "/home/vagrant/Sites", :nfs => true
  end
end
