#!/bin/bash

cd ${DEPLOY_DIR}
docker network create --driver overlay internal || true
docker stack deploy --compose-file docker-compose.yaml mysql
#envsubst < docker-compose.tpl > docker-compose.yaml
cat docker-compose.yaml
cd
rm -rf ${DEPLOY_DIR}


