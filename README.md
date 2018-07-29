# Quick Start PostgreSQL with Docker

Simple notes and scripts to help work with PostgreSQL in a container.

Relies heavily on CrunchyData provided container: [https://github.com/CrunchyData/crunchy-containers]()

# Initialize Container

1. (First time only) Initialize the container

        bash pginit.sh

That step is only required the first time.

The container is mapped to port `5432` on your localhost.

  * a container called `postgres` was configured and started.
  * the `./scripts` directory is mounted in the running container at /scripts
  * a database user and database were automatically created.        
  
# Using PostgreSQL with the Container

* Starting / Stopping container:

        docker start postgres
        
        docker stop postgres

* Running a script from the scripts directory.

        docker exec -it postgres psql -Ucoursera -h127.0.0.1 -f /scripts/example.sql

* Getting a `psql` prompt for ad-hoc commands:

        docker exec -it postgres psql -Ucoursera -h127.0.0.1        
        
* Exploring the container with commandline:

        docker exec -it postgres bash
        
* Remove container **(will delete entire database cluster, but your scripts folder will stay)**

        docker rm -f postgres

        
        
