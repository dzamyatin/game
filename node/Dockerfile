FROM ubuntu:20.04

USER root

RUN apt update

RUN apt install -y  \
    curl \
    nodejs && \
    printf "8\n34" | apt install -y nodejs npm

RUN npm cache clean -f && \
    npm install -g n && \
    n 20

COPY ./frontend /www

WORKDIR /www

RUN npm install && npm build

RUN apt install nginx -y

COPY ./node/nginx.conf /etc/nginx/nginx.conf

#CMD while true; do echo "hello" --verbose; sleep 1; done
CMD nginx -g 'daemon off;'