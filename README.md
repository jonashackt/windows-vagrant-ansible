# windows-vagrant-ansible
Bringing you fast and hassle-free to a running Windows Vagrant Box, if you need one (which comes probably only for tax software installations :P )


### HowTo

Download newest Microsoft Edge Windows 10 Vagrant zip from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/#downloads and unzip after download.

Then add it to Vagrant via

```
vagrant box add --name Windows10Edge Win10.box
```

Now fire up your Windows box with

```
vagrant up
```