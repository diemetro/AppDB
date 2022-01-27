version: '3.7'
services:

  mariadb:
    image: "mariadb:10.6.5"
    environment:
      MARIADB_ROOT_PASSWORD: "${MARIADB_ROOT_PASSWORD}"
    networks:
      - internal-net-${CI_COMMIT_REF_NAME}
    ports:
      - "3366:3306"
    volumes:
      - mariadb-data-${CI_COMMIT_REF_NAME}:/var/lib/mysql
    deploy:
      mode: replicated
      replicas: 1
      restart_policy:
        condition: any
        delay: 5s
        max_attempts: 5
        window: 10s
      labels:
        - traefik.enable=false

  adminer:
    image: phpmyadmin/phpmyadmin
    environment:
      PMA_HOST: "${PMA_HOST}"
    networks:
      - internal-net-${CI_COMMIT_REF_NAME}
      - traefik-net
    deploy:
      mode: replicated
      replicas: 1
      restart_policy:
        condition: any
        delay: 5s
        max_attempts: 5
        window: 10s
      labels:
        - "traefik.enable=true"
        - "traefik.http.routers.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.rule=Host(`${PROJECT_DOMAIN}`)"
        - "traefik.http.services.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.loadbalancer.server.port=80"
        - "traefik.http.routers.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.entrypoints=websecure"
        - "traefik.http.routers.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.entrypoints=web8088"
        - "traefik.http.routers.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.tls.certresolver=myresolver"
        - "traefik.http.routers.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}.middlewares=${PROJECT_NAME}-${CI_COMMIT_REF_NAME}-https"
        - "traefik.http.middlewares.${PROJECT_NAME}-${CI_COMMIT_REF_NAME}-https.redirectscheme.scheme=https"
        - "traefik.docker.network=traefik-net"

    depends_on:
      - mariadb

networks:
  internal-net-${CI_COMMIT_REF_NAME}:
    driver: overlay
    external: true
  traefik-net:
    driver: overlay
    external: true

volumes:
  mariadb-data-${CI_COMMIT_REF_NAME}:
