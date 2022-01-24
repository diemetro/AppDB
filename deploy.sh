#!/bin/bash

cd ${DEPLOY_DIR}
docker network create --driver overlay internal || true
docker stack deploy --compose-file docker-compose.yaml mysql
cd
rm -rf ${DEPLOY_DIR}


