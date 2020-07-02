ARG ubuntu_release='bionic'
ARG pcp_version='5.1.1'

FROM ubuntu:${ubuntu_release}

ENV DEBIAN_FRONTEND=noninteractive
ENV ver=$pcp_version

# Volumes
VOLUME /packages

# Install build dependencies
RUN rm -f /etc/dpkg/dpkg.cfg.d/excludes && \
  apt-get update && \
  apt-get -y install \
    build-essential \
    devscripts \
    fakeroot \
    debhelper \
    automake \
    autotools-dev \
    pkg-config \
    git \
    ca-certificates \
    --no-install-recommends

RUN apt-get install -y \
    libnspr4-dev \
    libnss3-dev \
    libsasl2-dev \
    libavahi-common-dev \
    zlib1g-dev \
    libdbd-mysql-perl \
    libnss3-tools \
    manpages

WORKDIR /pcp

RUN git clone https://github.com/performancecopilot/pcp.git /pcp && \
    git fetch && \
    git pull && \
    apt-get install -y $(qa/admin/check-vm -bfp) \
        python-influxdb \
        python3-influxdb

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
