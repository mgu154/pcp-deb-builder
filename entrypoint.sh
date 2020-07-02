#!/bin/bash

git checkout ${ver}
./Makepkgs --verbose
cp -vf build/deb/*.deb /packages
