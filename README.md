# docker-multicorn

Postgres 9.1 server with Multicorn foreign data wrappers

`docker build -t multicorn .`

If you have a Python project (with a `setup.py` file in its root), this Dockerfile has a `/src` shared volume that you can attach to. The startup script will run `python setup.py install` if the project is there.

`docker run -v /someproject:/src -t multicorn`

If you also have a file named `setup.sql`, it will run as well.

Environment Variables:

- `DB_USER`: The database user, default 'docker'
- `DB_PASS`: The database user's password, default 'docker'
- `DB_NAME`: The database to create, default 'multicorn'
