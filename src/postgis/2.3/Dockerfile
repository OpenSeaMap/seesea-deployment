FROM debian:9

LABEL maintainer="Steffen Volkmann (steffen@volkmann.com)"

ENV DEBIAN_FRONTEND=noninteractive

# Update stretch repositories
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' /etc/apt/sources.list

RUN    apt-get update \
    && apt-get install -y apt-utils 2>&1 | grep -v "debconf: delaying package configuration, since apt-utils is not installed" \
    && apt-get install -y --no-install-recommends \
    procps \
    nano \
    wget \
    unzip \
    sudo \
    net-tools \
    software-properties-common \
    locales \
    locales-all

RUN apt-get install -y --no-install-recommends \
    postgresql-9.6-postgis-2.3 \
    postgresql-9.6-postgis-scripts \
    postgresql-all  \
    postgresql-9.6  \
    postgresql-contrib-9.6 \
    build-essential \
    postgresql-server-dev-9.6 \
    git \
    libssl-dev \
    libkrb5-dev
    
    
 # install debugger extension   
 RUN mkdir -p  /usr/lib/postgresql/9.6/contrib/src \
    cd /usr/lib/postgresql/9.6/contrib/src \
    && git clone https://github.com/EnterpriseDB/pldebugger.git \
    && cd pldebugger \
    && export USE_PGXS=1 \
    && make \
    && make install

# Configure PosgtreSQL
COPY postgresql.custom.conf.tmpl /etc/postgresql/9.6/main/

RUN  mkdir /var/lib/postgresql/data \
  && chown -R postgres:postgres /var/lib/postgresql \
  && chown postgres:postgres /etc/postgresql/9.6/main/postgresql.custom.conf.tmpl \
  && echo "\ndata_directory = '/var/lib/postgresql/data'" >> /etc/postgresql/9.6/main/postgresql.conf \
  && echo "\ninclude 'postgresql.custom.conf'" >> /etc/postgresql/9.6/main/postgresql.conf \
  && cp /etc/postgresql/9.6/main/pg_hba.conf /etc/postgresql/9.6/main/pg_hba.conf.template

#RUN  echo "add rukes to pg_hba.conf" \
#  && echo "host  all             all             0.0.0.0/0              md5" >> /etc/postgresql/9.6/main/pg_hba.conf \
#  && echo "host  all             all             ::/0                   md5" >> /etc/postgresql/9.6/main/pg_hba.conf \
#  && echo "host  all             postgres        172.0.0.0/24           trust" >> /etc/postgresql/9.6/main/pg_hba.conf \
#  && echo "host  all             postgres        192.0.0.0/24           trust" >> /etc/postgresql/9.6/main/pg_hba.conf 


ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Start running
USER root
COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
CMD []
EXPOSE 5432
