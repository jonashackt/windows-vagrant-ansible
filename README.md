# windows-vagrant-ansible
Bringing you fast and hassle-free to a running Windows Vagrant Box, if you need one (which comes probably only for tax software installations :P )


The aim is to give you a no-brainer Windows box, just clone this repo, download & add the box and `vagrant up`.

If you need more stuff, add it to [playbook.yml](playbook.yml). Have fun!

## Prerequisites

> This guide assumes, you have VirtualBox, Vagrant, Python, pip & Ansible ready. On a Mac:

```
brew cask install virtualbox vagrant
brew install python
pip install ansible pywinrm
```

On Manjaro:

```
pamac install virtualbox vagrant
```

Ansible Windows connectivity is based on the `pywinrm` package, so we need to install it also.

## HowTo

<s>Download newest Microsoft Edge Windows 10 Vagrant zip from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/#downloads and unzip after download.</s>

Sadly Microsoft [discontinued the Windows Edge Dev Vagrant boxes](https://github.com/jonashackt/windows-vagrant-ansible/issues/3). So we need to use another way to get a good and up-to-date Windows Vagrant box. Since I look into the topic there was Stefan Scherer with it's famous https://github.com/StefanScherer/packer-windows around. But the boxes are also rather old now (2 years by the date of writing these lines: https://app.vagrantup.com/StefanScherer/boxes/windows_11) and don't really seem to be updated that much anymore.


### Download Windows 11 evaluation VirtualBox .ova

But maybe there's help & there is a way to add an already existant VirtualBox `.ova` as a VagrantBox: https://gist.github.com/aondio/66a79be10982f051116bc18f1a5d07dc. So let's try it.

Download a pre-packaged VirtualBox `.ova` here https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/ which already includes an evaluation version of Windows 11. The link should download the VirtualBox `.zip` file (22gigs will take their time depending on your Internet speed).


### Import .ova into VirtualBox

Unpack the `WinDev2309Eval.ova`.

Then add it to the local VirtualBox installation [via `VBoxManage import`](https://docs.oracle.com/en/virtualization/virtualbox/6.0/user/vboxmanage-import.html):

```
VBoxManage import ~/Downloads/WinDev2309Eval.VirtualBox/WinDev2309Eval.ova
```

This may take some time:

```
$ VBoxManage import ~/Downloads/WinDev2309Eval.VirtualBox/WinDev2309Eval.ova             1 ✘ 
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting /home/jonashackt/Downloads/WinDev2309Eval.VirtualBox/WinDev2309Eval.ova...
OK.
Disks:
  vmdisk1	134217728000	-1	http://www.vmware.com/interfaces/specifications/vmdk.html#streamOptimized	WinDev2309Eval-disk001.vmdk	-1	-1	

Virtual system 0:
 0: Suggested OS type: "Windows11_64"
    (change with "--vsys 0 --ostype <type>"; use "list ostypes" to list all possible values)
 1: Suggested VM name "WinDev2309Eval"
    (change with "--vsys 0 --vmname <name>")
 2: Suggested VM group "/"
    (change with "--vsys 0 --group <group>")
 3: Suggested VM settings file name "/home/jonashackt/VirtualBox VMs/WinDev2309Eval/WinDev2309Eval.vbox"
    (change with "--vsys 0 --settingsfile <filename>")
 4: Suggested VM base folder "/home/jonashackt/VirtualBox VMs"
    (change with "--vsys 0 --basefolder <path>")
 5: Number of CPUs: 4
    (change with "--vsys 0 --cpus <n>")
 6: Guest memory: 8192 MB
    (change with "--vsys 0 --memory <MB>")
 7: USB controller
    (disable with "--vsys 0 --unit 7 --ignore")
 8: Network adapter: orig NAT, config 3, extra slot=0;type=NAT
 9: SATA controller, type AHCI
    (disable with "--vsys 0 --unit 9 --ignore")
10: Hard disk image: source image=WinDev2309Eval-disk001.vmdk, target path=WinDev2309Eval-disk001.vmdk, controller=9;port=0
    (change target path with "--vsys 0 --unit 10 --disk path";
    change controller with "--vsys 0 --unit 10 --controller <index>";
    change controller port with "--vsys 0 --unit 10 --port <n>";
    disable with "--vsys 0 --unit 10 --ignore")
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Successfully imported the appliance.
```

Now the box is already available inside your VirtualBox gui. If you don't need automation, you can fire it up there and that's it.


### Create Vagrant box from VirtualBox VM

For us automation geeks, we want to create a Vagrant Box from it. So let's list the boxes via `VBoxManage list vms`:

```
$ VBoxManage list vms
"WinDev2309Eval" {9b9d8ad0-823b-48b3-aa95-9566f91ae47b}
```

Now we use `vagrant package` to create our box:

```
$ vagrant package --base 9b9d8ad0-823b-48b3-aa95-9566f91ae47b --output windows11eval.box
```

This will again take it's time. When the command finished we can add the Box to Vagrant:

```
vagrant box add windows11eval windows11eval.box
```


### Fire up Vagrant Windows box and delete other VirtualBox VM

Finally fire up your Windows box with

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

This step will again create a VirtualBox VM - so we can delete the old VM named `WinDev2309Eval`.


## Development of Ansible playbook

If your Vagrant box is running & provisioned, and you only want to execute the Ansible playbook, you can do so with:

```
vagrant provision --provision-with ansible
```


## Links

https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm

Running Powershell scripts as Vagrant provisioner: 
* https://blog.ipswitch.com/running-powershell-in-vagrant
* https://www.vagrantup.com/docs/provisioning/shell

Set NetworkConnection Profile to private from 
* https://www.itprotoday.com/powershell/how-force-network-type-windows-using-powershell