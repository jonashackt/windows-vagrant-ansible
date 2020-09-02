# windows-vagrant-ansible
Bringing you fast and hassle-free to a running Windows Vagrant Box, if you need one (which comes probably only for tax software installations :P )


### HowTo

> This guide assumes, you have VirtualBox, Vagrant, Python, pip & Ansible ready 

Download newest Microsoft Edge Windows 10 Vagrant zip from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/#downloads and unzip after download.

Then add it to Vagrant via

```
vagrant box add --name Windows10Edge Win10.box
```

Now fire up your Windows box with

```
vagrant up
```

There´s only one thing, that can cause the vagrant up to run into a “Timed out while waiting for the machine to boot […]”. This is because Microsoft sadly doesn´t configure the Network List Management Policies in a way, that Windows Remote Management (WinRM) could work together with Vagrant completely frictionless. To solve this we need to manually go into Local Security Policy / Network List Management Policies (after the Windows box is up and running), double klick on Network, go to tab Network Location and set the Location type to private and the User permissions to User can change location. Having made these changes, our vagrant up will work like a charm 

Now run the follow script on the Windows box in order to prepare it for access through Ansible:

```
iwr https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -UseBasicParsing | iex
```



Ansible Windows connectivity is based on the `pywinrm` package, so we need to install it first:

````
pip install pywinrm
```



Now let's execute our playbook

``` 
ansible-playbook -i hosts playbook.yml
```