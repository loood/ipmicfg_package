#!/bin/bash
set -e -x

sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list

apt-get update
apt-get install -y wget unzip
