#!/bin/bash

# Install script for Mininet Vagrant VM
# Adapted from https://github.com/kaichengyan/mininet-vagrant

MININET_VERSION="2.3.0"
POX_VERSION=angler


(cd mininet && git checkout $MININET_VERSION)
sed -i 's+git://github.com/mininet/openflow+https://github.com/mininet/openflow+g' mininet/util/install.sh
mininet/util/install.sh -nfvp
pushd pox
git checkout $POX_VERSION
popd


pushd Computer_Networks_Spring26/Assignment2/src/pox_module
sudo python setup.py develop

pkill -9 sr_solution
pkill -9 sr

popd

