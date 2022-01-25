version: '3.7'
services:

  mariadb:
    image: "mariadb:10.6.5"
    command: --init-file /docker-entrypoint-initdb.d/init.sql
    environment:
      MARIADB_ROOT_PASSWORD: "${MARIADB_ROOT_PASSWORD}"
    networks:
      - internal-net
    volumes:
      - "./build_env/mysql_users.sql:/docker-entrypoint-initdb.d/init.sql"
      - "/var/lib/mysql:/var/lib/mysql"
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
  internal-net:
    driver: overlay
    external: true

