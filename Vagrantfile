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
     vb.memory = 1024
     vb.cpus = 1
end

config.vm.define "httpd" do |httpd|
  httpd.vm.hostname = "httpd"
  httpd.vm.network "forwarded_port", guest: 8080, host: 18080 
  httpd.vm.network "private_network", ip: "192.168.100.100"
  httpd.vm.provision "shell", inline: <<-SHELL
     #yum update -y
     yum install httpd -y
     systemctl enable httpd
     systemctl start httpd 
     systemctl stop firewalld 
     cp /vagrant/mod_jk.so /etc/httpd/modules/
     echo "worker.list=lb" >> /etc/httpd/conf/workers.properties
     echo "worker.lb.type=lb" >> /etc/httpd/conf/workers.properties
     echo "worker.lb.balance_workers=tomcat1, tomcat2" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat1.host=tomcat1" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat1.port=8009" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat1.type=ajp13" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat2.host=tomcat1" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat2.port=8009" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat2.type=ajp13" >> /etc/httpd/conf/workers.properties
  SHELL
end




config.vm.define "tomcat1" do |tomcat1|
    tomcat1.vm.hostname = "tomcat1"
    tomcat1.vm.network "private_network", ip: "192.168.100.101"
    tomcat1.vm.provision "shell", inline: <<-SHELL
       echo "192.168.100.101 tomcat2" >> /etc/hosts
       #yum update -y
       yum install java-1.8.0-openjdk tomcat tomcat-webapps tomcat-admin-webapps -y
       systemctl disable firewalld
       systemctl enable tomcat 
       systemctl start tomcat 
       mkdir /usr/share/tomcat/webapps/testapp
       echo "111_tomcat_111" >> /usr/share/tomcat/webapps/testapp/index.html       
    SHELL
end

config.vm.define "tomcat2" do |tomcat2|
    tomcat2.vm.hostname = "tomcat2"
    tomcat2.vm.network "private_network", ip: "192.168.100.102"
    tomcat2.vm.provision "shell", inline: <<-SHELL
       #yum update -y
       yum install java-1.8.0-openjdk tomcat tomcat-webapps tomcat-admin-webapps -y
       systemctl disable firewalld
       systemctl enable tomcat 
       systemctl start tomcat 
       mkdir /usr/share/tomcat/webapps/testapp
       echo "222_tomcat_222" >> /usr/share/tomcat/webapps/testapp/index.html
    SHELL
end
end
