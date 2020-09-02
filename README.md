# windows-vagrant-ansible
Bringing you fast and hassle-free to a running Windows Vagrant Box, if you need one (which comes probably only for tax software installations :P )


The aim is to give you a no-brainer Windows box, just clone this repo, download & add the box and `vagrant up`.

If you need more stuff, add it to [playbook.yml]. Have fun!

### Prerequisites

> This guide assumes, you have VirtualBox, Vagrant, Python, pip & Ansible ready 

```
brew cask install virtualbox vagrant
brew install python
pip install ansible pywinrm
```

Ansible Windows connectivity is based on the `pywinrm` package, so we need to install it also.

### HowTo

Download newest Microsoft Edge Windows 10 Vagrant zip from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/#downloads and unzip after download.

Then add it to Vagrant via

```
vagrant box add --name Windows10Edge Win10.box
```

> You can also use this nice script to do so for you: https://github.com/chkpnt/MSEdge-Vagrant/blob/master/prepare.sh

Now fire up your Windows box with

```
vagrant up
```

This will also configure the Windows Box to work with Ansible and reduce the gory details (Network access, configure autologon to Windows)

After that, our Ansible [playbook.yml] is automatically executed and installs stuff on our box. Add stuff you need to it, currently only Firefox is installed.

If you don't have the [vagrant-reload](https://github.com/aidanns/vagrant-reload) plugin installed, Vagrant will prompt you to do so. Type `y` and enter:

```
Vagrant has detected project local plugins configured for this
project which are not installed.

  vagrant-reload
Install local plugins (Y/N) [N]: y
```



### Links

https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm

Running Powershell scripts as Vagrant provisioner: 
* https://blog.ipswitch.com/running-powershell-in-vagrant
* https://www.vagrantup.com/docs/provisioning/shell

Set NetworkConnection Profile to private from 
* https://www.itprotoday.com/powershell/how-force-network-type-windows-using-powershell