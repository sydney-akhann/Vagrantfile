# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

params = YAML.load_file 'parameters.yml'

Vagrant.configure(2) do |config|
  config.vm.define 'php55', primary: true do |php55|
    siteDir = params['php55']['site_dir']
    privateIp = params['php55']['private_ip']
    publicIp = params['php55']['public_ip']
    #bridge = params['php55']['bridge']

    php55.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

    php55.vm.network "private_network", ip: privateIp
    php55.vm.network "public_network", ip: publicIp#, :bridge => bridge

    php55.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site_php55.pp"
    end

    php55.vm.provision "shell", inline: "service apache2 restart", run: "always"

    php55.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.memory = "2048"
      vb.cpus = 1
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

    php53.vm.provision "shell", inline: "service apache2 restart", run: "always"

    php53.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.memory = "1024"
    end

    php53.vm.synced_folder ".", "/vagrant", :nfs => true
    php53.vm.synced_folder "~/Sites", "/home/vagrant/Sites", :nfs => true
  end

    config.vm.define 'php52', autostart: false do |php52|
        php52.vm.box = "box-cutter/ubuntu1004"

        php52.vm.network "public_network", ip: "192.168.1.45", auto_config: false
        php52.vm.network "private_network", ip: "192.168.2.4", auto_config: false

        # Set the Timezone to something useful
        config.vm.provision "shell", inline: "echo \"Indian/Mauritius\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        # Update version and install PHP 5.2 repository
        config.vm.provision "shell", inline: "apt-get update"
        config.vm.provision "shell", inline: "sudo apt-get -y upgrade"
        config.vm.provision "shell", inline: "sudo aptitude -y install python-software-properties"
        config.vm.provision "shell", inline: "sudo add-apt-repository ppa:andphe/php"
        config.vm.provision "shell", inline: "sudo aptitude update"

        # install apache
        config.vm.provision "shell", inline: "sudo apt-get install -y apache2"

        config.vm.provision "shell", inline: "sudo aptitude -y install php5-common=5.2.17.dfsg.1-0ubuntu0ppa3~lucid libapache2-mod-php5=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-cli=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-curl=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-mcrypt=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-gd=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-dev=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php-pear=5.2.17.dfsg.1-0ubuntu0ppa3~lucid php5-mysql=5.2.17.dfsg.1-0ubuntu0ppa3~lucid"

        # install mysql
        config.vm.provision "shell", path: "mysql.sh"

        php52.vm.provision "shell", inline: "service apache2 restart", run: "always"

        php52.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
          vb.memory = "1024"
        end

        php52.vm.synced_folder ".", "/vagrant", :nfs => true
        php52.vm.synced_folder "~/Sites", "/home/vagrant/Sites", :nfs => true
    end
end
