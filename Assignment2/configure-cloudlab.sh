#!/bin/bash

# Install script for Mininet Vagrant VM
# Adapted from https://github.com/kaichengyan/mininet-vagrant

MININET_VERSION="2.3.0"
POX_VERSION=angler

sudo apt install python-dev -y

(cd mininet && git checkout $MININET_VERSION)
sed -i 's+git://github.com/mininet/openflow+https://github.com/mininet/openflow+g' mininet/util/install.sh
mininet/util/install.sh -nfvp

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python get-pip.py
rm -f get-pip.py

pip install typing
pip install pathlib
pip install twisted
pip install ltprotocol


