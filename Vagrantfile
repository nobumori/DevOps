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

VM_COUNT = 2

config.vm.box = "bertvv/centos72"
config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = 2048
     vb.cpus = 1
   end

    config.vm.define "httpd" do |httpd|
    httpd.vm.hostname = "httpd"
    httpd.vm.network "forwarded_port", guest: 80, host: 8008 
    httpd.vm.network "forwarded_port", guest: 8080, host: 8080
    httpd.vm.network "forwarded_port", guest: 8081, host: 8081
    httpd.vm.network "private_network", ip: "192.168.100.100"
    httpd.vm.provision "shell", inline: <<-SHELL
       yum install -y java-1.8.0-openjdk
       yum install -y httpd
       yum install -y net-tools
       systemctl stop firewalld
       systemctl disable firewalld
       cp /vagrant/mod_jk.so /etc/httpd/modules/   
       echo "worker.list=lb" >> /etc/httpd/conf/workers.properties
       echo "worker.lb.type=lb" >> /etc/httpd/conf/workers.properties
       echo "worker.list=lb, status" >> /etc/httpd/conf/workers.properties
       echo "worker.status.type=status" >> /etc/httpd/conf/workers.properties
       echo "LoadModule jk_module modules/mod_jk.so" >> /etc/httpd/conf.d/lb.conf
       echo "JkWorkersFile conf/workers.properties" >> /etc/httpd/conf.d/lb.conf
       echo "JkShmFile /tmp/shm" >> /etc/httpd/conf.d/lb.conf
       echo "JkLogFile logs/mod_jk.log" >> /etc/httpd/conf.d/lb.conf
       echo "JkLogLevel info" >> /etc/httpd/conf.d/lb.conf
       echo "JkMount /testapp* lb" >> /etc/httpd/conf.d/lb.conf
       echo "JkMount /jkmanager* status" >> /etc/httpd/conf.d/lb.conf
       systemctl enable httpd
       
       wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
       rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
       yum -y install jenkins
       systemctl enable jenkins.service
       systemctl start jenkins.service
       mkdir /app && cd /app
       wget -c -N https://sonatype-download.global.ssl.fastly.net/nexus/oss/nexus-2.14.7-01-bundle.tar.gz
       tar xvf nexus-2.14.7-01-bundle.tar.gz -C /app
       ln -s /app/nexus-2.14.7-01/ /app/nexus
       adduser nexus
       chown -R nexus:nexus /app/nexus-2.14.7-01
       chown -R nexus:nexus /app/sonatype-work
       export NEXUS_HOME=/app/nexus 
       echo "RUN_AS_USER="nexus"" >> /app/nexus/bin/nexus
       cd /app/nexus/bin/
       ln -s /app/nexus/bin/nexus /etc/init.d/nexus
       systemctl enable nexus
       systemctl start nexus
       SHELL
    end
  
(1..VM_COUNT-1).each do |i|
  config.vm.define "httpd" do |httpd|
  httpd.vm.provision "shell", inline: <<-SHELL
     #yum update -y
     echo "worker.lb.balance_workers=tomcat#{i}" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat#{i}.host=192.168.100.10#{i}" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat#{i}.port=8009" >> /etc/httpd/conf/workers.properties
     echo "worker.tomcat#{i}.type=ajp13" >> /etc/httpd/conf/workers.properties
     systemctl start httpd
     SHELL
   end
  end

  (1..VM_COUNT-1).each do |i|  
   config.vm.define "tomcat#{i}" do |node|
   node.vm.hostname = "tomcat#{i}"
   node.vm.network "private_network", ip: "192.168.100.10#{i}"
   node.vm.provision "shell", inline: <<-SHELL
     #yum update -y
     yum install -y java-1.8.0-openjdk tomcat tomcat-webapps tomcat-admin-webapps
     systemctl stop firewalld
     systemctl disable firewalld
     systemctl enable tomcat 
     systemctl start tomcat 
     mkdir /usr/share/tomcat/webapps/testapp
     echo "tomcat #{i}" >> /usr/share/tomcat/webapps/testapp/index.html       
     SHELL
   end
  end
 end

