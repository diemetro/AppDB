version: '3.7'
services:

  mariadb:
    image: "mariadb:10.6.5"
    environment:
      MARIADB_ROOT_PASSWORD: "${MARIADB_ROOT_PASSWORD}"
    networks:
      - internal-net
    volumes:
      - "mariadb-data:/var/lib/mysql"
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

volumes:
  mariadb-data:
