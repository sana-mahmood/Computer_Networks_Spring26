# Instructions for setting up the Multipass environment for A2 On a Cloudlab server

These instructions are for students who use staff-provided Cloudlab servers. If you haven't been told by course staff to use this guide, please refer to README-VM.md file for instruction on how to set up an Ubuntu VM on your own machine.

## Logging into the cloudlab server
If you have followd the iinitial instructions in your email, you should already have set up your access to Cloudlab infrastructure. Please use the command in the confirmation email to log into the server. The SSH command for connecting to the server should have a similar format as:

```
ssh [your-cloudlab-username]@clnode[x].clemson.cloudlab.us
```
You can issue the above command as many times as you want to create parallel terminal sessions.

## Installing and testing Mininet


Open an SSH session to the server and run the following commands one by one.
```bash
sudo apt update 
sudo apt install python2 python-is-python2 unzip zip net-tools traceroute build-essential
cd ~
git clone https://github.com/mininet/mininet
git clone https://bitbucket.org/jhu-cs-comp-nets/assignments-spring24.git
sudo ./assignments-spring24/Assignment2/configure-cloudlab.sh
sudo ./assignments-spring24/Assignment2/install.sh
cd assignments-spring24/Assignment2/src
./run_pox.sh
```

Open a second shell and run:
```bash
cd assignments-spring24/Assignment2/src
./run_mininet.sh
```

In a third shell:
```bash
cd assignments-spring24/Assignment2/src
./sr_solution
```

In the second shell (mininet prompt):
```bash
client ping -c 3 192.168.2.2
```

We are set if the ping works!


## Developing on the virtual machine using VSCode
Your server comes with a public DNS name that you can use on VSCode.

Open your VSCode and install **Remote - SSH** extension. Click on the `><` button on the bottom left corner and select `connect to host...`.
Then add a new host entry like this: `<your-cloudlab-username>@<public-server-name>` and try connecting to the VM (this is exactly the same as the command your use to SSH into the server). After the connection is established (usually takes 30 seconds), open the file explorer and select the assignments-spring24 directory. 


See this guide for more information: https://code.visualstudio.com/docs/remote/ssh
