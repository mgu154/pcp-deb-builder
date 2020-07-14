ARG dis='ubuntu'
ARG rel='bionic'
ARG pcp='5.1.1'

FROM ${dis}:${rel}

ENV DEBIAN_FRONTEND=noninteractive
ENV pcp=$pcp
ENV dis=$dis
ENV rel=$rel

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
        python3-influxdb \
        python3-pil \
        python-pil \
        libmicrohttpd-dev \
        qtbase5-dev \
        qtbase5-dev-tools \
        libqt5svg5-dev \
        libcairo2-dev \
        qtchooser

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
