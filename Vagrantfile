Vagrant.configure("2") do |config|
  config.vm.box = "Windows10Edge"
  config.vm.guest = :windows

  # Configure Vagrant to use WinRM instead of SSH
  config.vm.communicator = "winrm"

  # Configure WinRM Connectivity
  config.winrm.username = "IEUser"
  config.winrm.password = "Passw0rd!"

  config.vm.provider "virtualbox" do |vb|
      vb.name = "Windows10Ansible"
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      # Use full screen on mac
      vb.customize ["modifyvm", :id, "--vram", "32"]
      # Using VirtualBox 6.x+ default VBoxSVGA instead of VBoxVGA
      vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxsvga"]
   end
end