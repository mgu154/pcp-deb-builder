#!/bin/bash

dis=${dis:-''}
rel=${rel:-''}
pcp=${pcp:-''}

dest="/packages/$dis/$rel/$pcp"

git checkout "${pcp}"
./Makepkgs --verbose

[[ -d $dest ]] || mkdir -pv "$dest"
cp -vf build/deb/*.deb "$dest"
