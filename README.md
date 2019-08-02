# docker-multicorn

Use this project as a quick way to get started with Postgres FDW using Multicorn.

It contains:

* Dockerfile with:
    * Postgres 11
    * Python3.7
    * Multicorn 1.3.4

* Sample FDW implementation in `src/`

* docker-compose to quick run locally

## Getting started


### Build image


`docker build -t multicorn .`

or

`docker-compose build .`

### Running

`docker run -v /some_project:/src -t multicorn`

or

`docker-compose up`

During first execution, the `start.sh` script will create the user and database in Postgres and
install the module given in the `src` volume. For more details check [here](src/README.md). 

### Configuration

You can customize the Postgres settings by providing the following environment variables:

DB_USER: The database user, default 'docker'

DB_PASS: The database user's password, default 'docker'

DB_NAME: The database to create, default 'multicorn'

#### This project was based on: https://github.com/mike-douglas/docker-multicorn
