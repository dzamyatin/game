FROM nginx:1.23.2

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/fastcgi_params /etc/nginx/fastcgi_params

COPY ./nginx/cert.pem /etc/nginx/cert.pem
COPY ./nginx/key.pem /etc/nginx/key.pem

COPY ./backend /www

WORKDIR /www