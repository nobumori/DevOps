# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

config.vm.box = "bertvv/centos72"
config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = 2048
     vb.cpus = 2
   end

    config.vm.define "httpd" do |httpd|
    httpd.vm.hostname = "httpd"
    httpd.vm.network "forwarded_port", guest: 9200, host: 19200 

    httpd.vm.network "private_network", ip: "192.168.100.100"
    httpd.vm.provision "shell", inline: <<-SHELL
       systemctl stop firewalld
       systemctl disable firewalld
       cd /tmp
       rpm -Uvh https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm



  
     SHELL
    end
  

   
  end
 

