#!/bin/bash

# Install script for Mininet Vagrant VM
# Adapted from https://github.com/kaichengyan/mininet-vagrant

MININET_VERSION="2.3.0"
POX_VERSION=angler

sudo chown -R ubuntu:ubuntu mininet
sudo chown -R ubuntu:ubuntu Computer_Networks_Spring26

(cd mininet && git checkout $MININET_VERSION)
sed -i 's+git://github.com/mininet/openflow+https://github.com/mininet/openflow+g' mininet/util/install.sh
mininet/util/install.sh -nfvp

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python get-pip.py
rm -f get-pip.py

sudo pip install pathlib
sudo pip install twisted
sudo pip install ltprotocol


