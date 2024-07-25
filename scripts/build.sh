#!/bin/bash
set -e -x
VERSION=1.35.2
BUILD=240627
URL_BUILD=760
wget \
	https://www.supermicro.com/Bios/sw_download/${URL_BUILD}/IPMICFG_${VERSION}_build.${BUILD}.zip

mkdir -p ipmicfg
mkdir -p ipmicfg/opt/ipmicfg/bin ipmicfg/opt/ipmicfg/docs
echo "See https://www.supermicro.com/about/policies/disclaimer.cfm" > ipmicfg/opt/ipmicfg/docs/LICENSE
unzip -j IPMICFG_${VERSION}_build.${BUILD}.zip -d ipmicfg/opt/ipmicfg/bin/ IPMICFG_${VERSION}_build.${BUILD}/Linux/64bit/IPMICFG-Linux.x86_64
unzip -j IPMICFG_${VERSION}_build.${BUILD}.zip -d ipmicfg/opt/ipmicfg/docs/ IPMICFG_${VERSION}_build.${BUILD}/ReleaseNotes.txt
chmod 0644 ipmicfg/opt/ipmicfg/docs/ReleaseNotes.txt
ln -s IPMICFG-Linux.x86_64 ipmicfg/opt/ipmicfg/bin/ipmicfg
cp -r /workspace/DEBIAN/ ipmicfg/
mkdir -p "/workspace/dist/${UBUNTU_CODENAME}"
dpkg-deb --build ipmicfg "/workspace/dist/${UBUNTU_CODENAME}/"
chown --reference /workspace -R /workspace/dist/
