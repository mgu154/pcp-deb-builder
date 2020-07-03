# pcp-deb-builder
Prepares Performance Co-Pilot deb packages for Ubuntu
```
rel='bionic'
pcp='5.1.1'
mkdir -pv packages
docker build --build-arg ubuntu_release=$rel --build-arg pcp_version=$pcp -t pcp:${rel} .
docker run -v $(pwd)/packages:/packages --rm --name pcp_$(date "+%s") -e ver=$pcp pcp:${rel}
```
deb packages should be placed in the packages directory.
