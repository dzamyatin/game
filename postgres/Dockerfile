#https://hub.docker.com/_/postgres
FROM postgres:15.3

USER root

ENV POSTGRES_PASSWORD=password
ENV POSTGRES_USER=user
ENV POSTGRES_DB=postgres
ENV PGDATA=/home/user/data

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user

RUN mkdir -p ${PGDATA} && \
    chown -R user:user ${PGDATA} && \
    chmod -R 750 ${PGDATA}

USER user

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh postgres

#ENTRYPOINT while true; do echo "hello" --verbose; sleep 1; done;
