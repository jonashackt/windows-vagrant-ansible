Vagrant.configure("2") do |config|
  config.vm.box = "windows11eval"
  config.vm.guest = :windows
  # specify the name of the Vagrant box instance, later needed by ansible
  config.vm.define "windowsbox"

  # needed plugins
  config.vagrant.plugins = ["vagrant-reload"]

  # Use winrm instead of default ssh
  config.vm.communicator = "winrm"

  # Configure WinRM Connectivity
  config.winrm.username = "User"
  config.winrm.password = "test"
  config.winrm.port = 5985
  config.winrm.basic_auth_only = true
  config.winrm.ssl_peer_verification = false
  config.winrm.transport = :plaintext

  config.vm.provider "virtualbox" do |vb|
      vb.name = "Windows11Ansible"
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      # Use full screen on mac
      vb.customize ["modifyvm", :id, "--vram", "32"]
      # Using VirtualBox 6.x+ default VBoxSVGA instead of VBoxVGA
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxsvga"]
      # Have Windows show up with 200% scale factor
      vb.customize ['setextradata', :id, 'GUI/ScaleFactor', '2.00']
      # drag & drop baby
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
   end

  # Configure Windows Box to allow Ansible connectivity
  # Therefore we use a Powershell script, executed via Vagrant shell provisioner (https://www.vagrantup.com/docs/provisioning/shell)
  config.vm.provision "shell", path: "powershell/configureAutologon.ps1" 
  # Reload box after autologin is active (using https://github.com/aidanns/vagrant-reload)
  config.vm.provision "reload"
  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "powershell/configureNetworkAccess.ps1" 
  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", path: "powershell/configureAnsibleAccess.ps1"

  # Run our Ansible playbook
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "playbook.yml"
    # overriding generated inventory configuration, see https://www.vagrantup.com/docs/provisioning/ansible_intro#host-variables
    ansible.host_vars = {
      "windowsbox" => {
        # we can only connect through 55986 and not the default 55985
        "ansible_port" => 55986,
        # work around ssl: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed error
        "ansible_winrm_server_cert_validation" => "ignore"
      }
    }
  end

end