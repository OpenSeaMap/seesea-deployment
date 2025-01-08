FROM debian:11

LABEL maintainer="Steffen Volkmann (steffen@volkmann.com)"

ENV DEBIAN_FRONTEND=noninteractive

RUN    apt-get update \
    && apt-get install -y apt-utils 2>&1 | grep -v "debconf: delaying package configuration, since apt-utils is not installed" \
    && apt-get install -y --no-install-recommends \
    procps \
    nano \
    wget \
    unzip \
    sudo \
    software-properties-common \
    apt-transport-https 

RUN apt-get install -y --no-install-recommends \
    postgresql-common

RUN apt-get install -y --no-install-recommends \
    postgresql-13-postgis-3 \
    postgresql-13-postgis-scripts

RUN apt-add-repository 'deb http://archive.debian.org/debian stretch main contrib non-free' \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
   openjdk-8-jdk \
   maven 

RUN apt-get install -y --no-install-recommends \
    net-tools \
    iputils-ping \
    cron \
    rsync

# Start running
USER root
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
CMD []
EXPOSE 8080