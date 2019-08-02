FROM ubuntu:19.04

ENV PG_VERSION 11
ENV DEBIAN_FRONTEND=noninteractive

ARG STD_TIMEZONE=UTC

RUN apt-get update -qq && apt-get upgrade -y && \
    apt-get -y install python3-pip python3-dev build-essential postgresql postgresql-server-dev-${PG_VERSION} postgresql-${PG_VERSION}-python3-multicorn && \
    ln -fs /usr/share/zoneinfo/${STD_TIMEZONE} /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    cd /usr/local/bin && ln -s /usr/bin/python3 python

### Open Postgres ports
RUN mkdir -p /etc/postgresql/${PG_VERSION}/main && \
    echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/${PG_VERSION}/main/pg_hba.conf && \
    echo "listen_addresses = '*'" >> /etc/postgresql/${PG_VERSION}/main/postgresql.conf && \
    echo "port = 5432" >> /etc/postgresql/${PG_VERSION}/main/postgresql.conf

EXPOSE 5432

VOLUME /src

ADD start.sh /start.sh
RUN chmod a+x /start.sh

ENV DB_USER docker
ENV DB_PASS docker
ENV DB_NAME multicorn

CMD ["/start.sh"]