#!/bin/bash

DB_USER=${DB_USER}
DB_PASS=${DB_PASS}
DB_NAME=${DB_NAME}
PG_VERSION=${PG_VERSION}

SU='/bin/su postgres -c'

rm /var/lib/postgresql/${PG_VERSION}/main/postmaster.pid /var/run/postgresql/.*.lock
service postgresql start

if [ ! -e '/done_setup' ]; then

    echo "### Executing SETUP"

    echo "### Configuring Postgres"
    ${SU} "createdb ${DB_NAME}"
    ${SU} "createuser -d -s -r -l ${DB_USER}"
    ${SU} "psql postgres -c \"ALTER USER ${DB_USER} WITH ENCRYPTED PASSWORD '${DB_PASS}'\""

    if [ -e '/src/setup.sh' ]; then
        echo "### Running setup.sh"
        cd /src && bash setup.sh
    fi

    if [ -e '/src/setup.py' ]; then
        echo "### Running setup.py"
        cd /src && python setup.py install
    fi

    if [ -e '/src/setup.sql' ]; then
        echo "### Running setup.sql"
        ${SU} "psql ${DB_NAME} < /src/setup.sql"
    fi

    echo 1 > /done_setup
fi

tail -f /var/log/postgresql/postgresql-${PG_VERSION}-main.log