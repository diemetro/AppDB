#!/bin/bash

cd ${DEPLOY_DIR}
docker network create --driver overlay internal || true
docker-compose up -d
cd
rm -rf ${DEPLOY_DIR}

