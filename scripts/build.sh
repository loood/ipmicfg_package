#!/bin/bash
set -e -x
ZIP_FILENAME=IPMICFG_1.35.1_build.230912.zip
wget \
	https://www.supermicro.com/Bios/sw_download/642/$ZIP_FILENAME

mkdir -p ipmicfg
mkdir -p ipmicfg/opt/ipmicfg/bin ipmicfg/opt/ipmicfg/docs
echo "See https://www.supermicro.com/about/policies/disclaimer.cfm" > ipmicfg/opt/ipmicfg/docs/LICENSE
unzip -j $ZIP_FILENAME -d ipmicfg/opt/ipmicfg/bin/ IPMICFG_1.35.1_build.230912/Linux/64bit/IPMICFG-Linux.x86_64
unzip -j $ZIP_FILENAME -d ipmicfg/opt/ipmicfg/docs/ IPMICFG_1.35.1_build.230912/ReleaseNotes.txt
chmod 0644 ipmicfg/opt/ipmicfg/docs/ReleaseNotes.txt
ln -s IPMICFG-Linux.x86_64 ipmicfg/opt/ipmicfg/bin/ipmicfg
cp -r /workspace/DEBIAN/ ipmicfg/
mkdir -p "/workspace/dist/${UBUNTU_CODENAME}"
dpkg-deb --build ipmicfg "/workspace/dist/${UBUNTU_CODENAME}/"
chown --reference /workspace -R /workspace/dist/
