#!/bin/sh
set -ex
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
echo "deb http://repos.mesosphere.com/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -qq update
sudo apt-get install -qq mesos
