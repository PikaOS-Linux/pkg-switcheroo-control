#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.freedesktop.org/hadess/switcheroo-control -b 2.6
cp -rvf ./debian ./switcheroo-control/
cd ./switcheroo-control

for i in ../patches/* ; do echo "Applying Patch: $i" && patch -Np1 -i $i || echo "Applying Patch $i Failed!"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
