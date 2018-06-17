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
  config.vm.box = "windows_10_virtualbox.box"
  config.vm.define "windows_10_virtualbox"
  config.vm.communicator = "winrm"

  # Admin user name and password
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.guest = :windows
  config.windows.halt_timeout = 15

  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true

  config.vm.provider :virtualbox do |v, override|
      v.gui = true
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", 2]
      v.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
  end
  config.vm.provision "shell", run: "always" do |s|
    p = File.expand_path("../",__FILE__)
    s.path = p + "/Provision/provision.ps1"
  end
  # config.vm.provision "shell" do |s|
  #   p = File.expand_path("../",__FILE__)
  #   s.path = p + "/Provision/AddSoftware.ps1"
  #  end
  # config.vm.provision "shell" do |s|
  #   p = File.expand_path("../",__FILE__)
  #   s.path = p + "/Provision/WildFly.ps1"
  # end
end
