#!/bin/bash

WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# Helper script for using PostgreSQL in docker container
# for local testing and development as well as coursework.
#

# docker image tag
CCP_IMAGE_TAG=centos7-9.6.9-1.8.3
CCP_IMAGE_PREFIX=crunchydata
#CCP_IMAGE_TAG=centos7-10.4-1.8.3

PG_DATABASE=coursera
PG_USER=coursera
PG_PASSWORD=changeit
PG_ROOT_PASSWORD=changeit

if [ $# -eq 0 ]; then
    CONTAINER_NAME=postgres
else
    CONTAINER_NAME=$1
fi

docker run -d \
    -v ${WORKSPACE}/scripts:/scripts \
    -v ${WORKSPACE}/pgconf:/pgconf \
    -e PG_DATABASE=${PG_DATABASE} \
    -e PG_USER=${PG_USER} \
    -e PG_PASSWORD=${PG_PASSWORD} \
    -e PG_PRIMARY_USER=primaryuser \
    -e PG_PRIMARY_PASSWORD=changeit \
    -e PG_ROOT_PASSWORD=${PG_ROOT_PASSWORD} \
    -e PG_MODE=primary \
    -e PG_PRIMARY_PORT=5432 \
    --name=${CONTAINER_NAME} \
    --hostname=${CONTAINER_NAME} \
    $CCP_IMAGE_PREFIX/crunchy-postgres:$CCP_IMAGE_TAG

echo "===="
echo "PostgreSQL Docker container running called: ${CONTAINER_NAME}"
echo "Database User: '${PG_USER}', with password '${PG_PASSWORD}'"
echo "PostgreSQL admin user is 'postgres' with password '${PG_PASSWORD}'"
echo "===="

#TODO: if we want to update in this script, we need to loop until the container startup is completed
#update configuration to allow passwordless login from localhost once connected to container
#docker exec -it ${CONTAINER_NAME} sed -i 's/\(^host.*\)\(127\.0\.0\.1\/32\)\( *\)md5/\1\2\3trust/' /pgdata/${CONTAINER_NAME}/pg_hba.conf
#docker restart ${CONTAINER_NAME}
