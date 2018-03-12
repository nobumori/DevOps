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
     vb.cpus = 1
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
       yum install -y java-1.8.0-openjdk
       yum install -y net-tools
       yum install -y curl
       yum install -y yum-utils
       yum install -y epel-release
       yum install -y collectd
       echo "<Plugin "network">" >> /etc/collectd.conf
       echo "Server "192.168.100.100" "25826"" >> /etc/collectd.conf
       echo "</Plugin "network">" >> /etc/collectd.conf
       yum-config-manager \ --add-repo \ https://download.docker.com/linux/centos/docker-ce.repo
       yum install -y docker-ce
       systemctl enable docker
       systemctl start docker
       docker run -d --name=grafana -p 3000:3000 grafana/grafana
      #  echo "[[collectd]]" >> /etc/influxdb/influxdb.conf
      #  echo "enabled = true" >> /etc/influxdb/influxdb.conf
      #  echo "bind-address = ":25826"" >> /etc/influxdb/influxdb.conf
      #  echo "typesdb = "/usr/share/collectd/types.db"" >> /etc/influxdb/influxdb.conf
      #  echo "database = "collectd"" >> /etc/influxdb/influxdb.conf

  
     SHELL
    end
  

    config.vm.define "tomcat" do |node|
    node.vm.hostname = "tomcat"
    node.vm.network "private_network", ip: "192.168.100.101"
    node.vm.provision "shell", inline: <<-SHELL
       yum install -y net-tools
       yum install -y yum-utils
       yum install -y curl
       yum install -y epel-release
       yum install -y collectd
       echo "<Plugin "network">" >> /etc/collectd.conf
       echo "Server "192.168.100.101" "25826"" >> /etc/collectd.conf
       echo "</Plugin "network">" >> /etc/collectd.conf 
       echo "[[collectd]]" >> /etc/influxdb/influxdb.conf
       echo "enabled = true" >> /etc/influxdb/influxdb.conf
       echo "bind-address = ":25826"" >> /etc/influxdb/influxdb.conf
       echo "typesdb = "/usr/share/collectd/types.db"" >> /etc/influxdb/influxdb.conf
       echo "database = "collectd"" >> /etc/influxdb/influxdb.conf      
     SHELL
   end
  end
 

