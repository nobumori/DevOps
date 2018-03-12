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
     vb.memory = 2848
     vb.cpus = 2
   end

    config.vm.define "httpd" do |httpd|
    httpd.vm.hostname = "httpd"
    httpd.vm.network "forwarded_port", guest: 9200, host: 19200 
    httpd.vm.network "forwarded_port", guest: 5044, host: 15044
    httpd.vm.network "forwarded_port", guest: 5601, host: 15601
    httpd.vm.network "forwarded_port", guest: 3000, host: 13000
    httpd.vm.network "forwarded_port", guest: 8086, host: 18086
    httpd.vm.network "private_network", ip: "192.168.100.100"
    httpd.vm.provision "shell", inline: <<-SHELL
       systemctl stop firewalld
       systemctl disable firewalld
       yum install -y epel-release
       yum install -y java-1.8.0-openjdk
       yum install -y net-tools
       yum install -y curl
       yum install -y yum-utils
       yum-config-manager \ --add-repo \ https://download.docker.com/linux/centos/docker-ce.repo
       yum install -y docker-ce
       systemctl enable docker
       systemctl start docker
       cd /vagrant
       wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.0.1-1.x86_64.rpm
       yum localinstall -y grafana-5.0.1-1.x86_64.rpm
       yum install -y collectd

  
     SHELL
    end
  

    config.vm.define "tomcat" do |node|
    node.vm.hostname = "tomcat"
    node.vm.network "private_network", ip: "192.168.100.101"
    node.vm.provision "shell", inline: <<-SHELL
       systemctl stop firewalld
       systemctl disable firewalld
       yum install -y epel-release
       yum install -y net-tools
       yum install -y yum-utils
       yum install -y curl
       yum install -y collectd
  
     SHELL
   end
  end
 

