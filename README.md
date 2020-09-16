# pcp-deb-builder
Prepares Performance Co-Pilot deb packages for Ubuntu
```
dis='ubuntu'
rel='focal'
pcp='5.2.0'

mkdir -pv packages/ubuntu/{xenial,bionic,focal}
mkdir -pv packages/debian/{jessie,stretch}

docker build \
    --build-arg dis=$dis \
    --build-arg rel=$rel \
    --build-arg pcp=$pcp \
    -t ${dis}-${rel}-pcp .

docker run \
    -v $(pwd)/packages:/packages \
    --rm \
    --name pcp_$(date "+%s") \
    -e pcp=$pcp \
    -e dis=$dis \
    -e rel=$rel \
    ${dis}-${rel}-pcp
```
deb packages should be placed in the packages directory.
