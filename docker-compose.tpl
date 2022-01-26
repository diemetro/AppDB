version: '3.7'
services:

  mariadb:
    image: "mariadb:10.6.5"
    environment:
      MARIADB_ROOT_PASSWORD: "${MARIADB_ROOT_PASSWORD}"
    networks:
      - internal-net-${CI_COMMIT_REF_NAME}
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

networks:
  internal-net-${CI_COMMIT_REF_NAME}:
    driver: overlay
    external: true

volumes:
  mariadb-data-${CI_COMMIT_REF_NAME}:
