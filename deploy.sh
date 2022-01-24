#!/bin/bash

cd ${DEPLOY_DIR}
docker network create --driver overlay internal || true
envsubst < docker-compose.tpl > docker-compose.yaml
cat docker-compose.yaml
docker stack deploy --compose-file docker-compose.yaml mysql
cd
rm -rf ${DEPLOY_DIR}


