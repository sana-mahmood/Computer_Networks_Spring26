# Instructions for testing Multipass environment (A3)
1. Clone This repository
2. Install Multipass on your system. Follow the instructions in this link to install Multipass: [https://multipass.run/install](https://multipass.run/install).
Multipass is a Ubuntu VM orchastrator. It quickly and easily installs VMs using you system's default hypervisor.
3. Launch an Ubuntu VM that you can use to develop and test your code. Run: 
```bash
cd assignments-spring25/Assignment3
multipass launch focal -n cn-a3 --cloud-init config.yaml
```
After the VM launches, use the following command to open as many shells as you need:
```bash
multipass shell cn-a3
```

## Developing on the virtual machine using VSCode
Multipass automatically assigns an IP address to the VM which is accible from your host machine. If you enable the remote-SSH extention in VSCode, you can develop your code remotely.
To find the IP address of your Ubuntu VM, run:

```bash
multipass list
```

In this guide, we will setup SSH key authentication from your host to the virtual machine.
The first step is to find your host's public key.
In your powershell (Windows) or terminal (Mac/Linux) type this in your **home** directory:
```bash
cat .ssh/id_rsa.pub
```
If this command returns your public key, copy it into your clipboard. If id_rsa.pub is not found see below on **creating a new key pair**.

Then login to the VM's shell and paste the public key in **authorized_keys** file:
```bash
multipass shell cn-a3
nano .ssh/authorized_keys
# paste the key in a new line at the end of the file, save and exit!
```
Now, you will have SSH access to the VM. Using the IP address that you grabbed from ```multipass list``` command, try SSHing into the VM:
```
ssh ubuntu@<ip address>
```
If you see VM's shell, the next step is to set up VSCode. Open your VSCode and install **Remote - SSH** extension. Click on the `><` button on the bottom left corner and select `connect to host...`.
Then add a new host entry like this: `ubuntu@<VM IP address>` and try connecting to the VM. After the connection is established (usually takes 30 seconds), open the file explorer and select the assignments-spring25 directory. 


See this guide for more information: https://code.visualstudio.com/docs/remote/ssh

### Creating a new key pair
Windows powershell, Linux, and Mac all use openssh by default to manage ssh keys. In your terminal simply type:
```bash
ssh-keygen
```
and follow the prompts. Usually, you will want to use the default location and name for your key pair and you won't need a passphrase for it either. So, you can press Enter 3 times!

## Transferring your code from/to the virtual machine
You can use the following commands to transfer files to and from the VM if you prefer to develop your code locally on your machine.

To use this method, create a private repository for yourself, copy the reposory address and use the following command in the `assignments-spring25` directory inside the VM to add a new remote:

```bash
git remote add private <your private repository address>
```

Then you can use ```git push private master``` or ```git pull private master``` to move data from/to the VM!


```bash
# transfer from your machine to VM
multipass transfer /path/to/source cn-a3:/path/to/destination
# transfer from the VM to your machine
multipass transfer cn-a3:/path/to/source /path/to/destination
```

## Using git to move your code from/to the virtual machine
Your VM should have internet access if installed correctly. You can use your own private git repository to move code from/to the virtual machine.

### FAQ
Q: Can I run my code on my own system instead of the virtual machine?

A: Depends on the assignment and your operating system! We have ensured that all the assignments can be run in this VM. Please refer to the individual assignment README files to see what environments are supported. As a summary:

Linux users: Except for Assignment 2, you can use your own system to develop and test!

MAC users: Except for Assignments 2 and 3, you can use your own system to develop and test!

Windows users: You can use WSL for all assignments except Assignment 2.

Q: Do I need to install any software dependencies to use Multipass?

Linux users can install multipass using **snap** which will automatically take care of dependencies. Mac users, similarly, will use brew. Some Windows users might see this warning during Multipass installation: "Oracle Virtualbox is required on Windows Home Edition". If HyperV is unavailable in your system, please follow [this](https://www.virtualbox.org/wiki/Downloads) link to install Virtualbox after installing Multipass. 

### A note for Windows users who use Virtualbox
We have noticed that when you are connected to JHU network, the VM will not be assigned an IP address. The easiest workaround is to connect to your mobile hotspot before creating the VM. 