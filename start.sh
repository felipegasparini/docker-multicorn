#!/bin/bash

DB_USER=${DB_USER}
DB_PASS=${DB_PASS}
DB_NAME=${DB_NAME}

SU='/bin/su postgres -c'

rm /var/lib/postgresql/9.3/main/postmaster.pid /var/run/postgresql/.*.lock
service postgresql start

if [ ! -e '/done_setup' ]; then
    ${SU} "createdb ${DB_NAME}"
    ${SU} "createuser -d -s -r -l ${DB_USER}"
    ${SU} "psql postgres -c \"ALTER USER ${DB_USER} WITH ENCRYPTED PASSWORD '${DB_PASS}'\""
    
    if [ -e '/src/setup.py' ]; then
        cd /src && python setup.py install
    fi

    if [ -e '/src/setup.sql' ]; then
        ${SU} "psql ${DB_NAME} < /src/setup.sql"
    fi
    
    echo 1 > /done_setup
fi

tail -f /var/log/postgresql/postgresql-9.3-main.log
