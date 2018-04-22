# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#

Vagrant.configure("2") do |config|
  config.vm.define :jaasslavehost, primary: true do |jaasslavehost|
    jaasslavehost.vm.box = "kaltepeter/jaasslavehost"
    jaasslavehost.vm.box_version = "1.0.7"
    jaasslavehost.vm.hostname = "jaasslavehost"
    jaasslavehost.vm.box_check_update = true

    # jaasslavehost.vm.network "forwarded_port", guest: 22, host: 2224
    jaasslavehost.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"
    jaasslavehost.vm.network "forwarded_port", guest: 2376, host: 2376
    jaasslavehost.vm.network "forwarded_port", guest: 4243, host: 4243

    # jaasslavehost.vm.network "private_network", ip: "172.19.0.30"
    jaasslavehost.vm.network "private_network", ip: "172.19.0.30"
    # config.vm.provision "shell",
    #                     run: "always",
    #                     inline: "ifconfig eth0 172.19.0.17 netmask 255.255.255.0 up"

    jaasslavehost.vm.provision "shell", path: "provision.sh", privileged: false
    jaasslavehost.vm.provision "shell", path: "add_docker_group.sh", privileged: true
  end
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "kaltepeter/jaasslavehost"
  # config.vm.box_version = "1.0.2"
  # config.vm.hostname = "jaasslavehost"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 22, host: 2224, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 2376, host: 2376, host_ip: "127.0.0.1"
  # config.vm.network "forwarded_port", guest: 4243, host: 4243, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "private_network", ip: "192.168.0.16"
  # config.vm.network "public_network", bridge: "en1: Wi-Fi (AirPort)", ip: "192.168.1.16"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   vb.name = 'jaasslavehost'
  #   # Display the VirtualBox GUI when booting the machine
  #   # vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   # vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", path: "provision.sh", privileged: false
end