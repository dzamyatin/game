#!make
include .env

dev:
	make -s cert
	@make -s authority
	make build
	make up
	ARGS=install make composer
up:
	docker-compose -f ./docker-compose.yml up -d --remove-orphans
	echo "\n\n\n-------------\n Ready to serve connection by `cat ./.env | grep SSL_EXTERNAL_PORT | sed --expression='s/SSL_EXTERNAL_PORT=//g'` \n-------------\n"
down:
	docker-compose -f ./docker-compose.yml down
build:
	docker-compose -f ./docker-compose.yml build
dphp:
	docker exec -ti ${PROJECT_NAME}-php-fpm bash
dnginx:
	docker exec -ti ${PROJECT_NAME}-nginx bash
dpg:
	docker exec -ti ${PROJECT_NAME}-postgres bash
dnode:
	docker exec -ti ${PROJECT_NAME}-node bash
lnode:
	docker logs -f ${PROJECT_NAME}-node
lphp:
	docker logs -f ${PROJECT_NAME}-php-fpm
lnginx:
	docker logs -f ${PROJECT_NAME}-nginx
lpostgres:
	 docker logs -f ${PROJECT_NAME}-postgres
cert:
	openssl req -x509 -newkey rsa:4096 -keyout nginx/key.pem -out nginx/cert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=localhost"
	echo "\n\n-------\n Add cert to authority `pwd`/nginx/cert.pem >> /etc/ssl/certs/ca-certificates.crt \n--------\n"
authority:
	sudo sh -c "rm -f /usr/local/share/ca-certificates/${PROJECT_NAME}-local*.crt | cp ./nginx/cert.pem /usr/local/share/ca-certificates/${PROJECT_NAME}-local`date +%s`.crt && update-ca-certificates"
composer:
	docker exec -ti ${PROJECT_NAME}-php-fpm sh -c "cd / && php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\" \
&& php composer-setup.php && php -r \"unlink('composer-setup.php');\"; \
apt-get update && \
apt install -y git && \
cd /www && \
php ../composer.phar $(ARGS)"
front:
	docker exec -ti ${PROJECT_NAME}-node sh -c "npm install && npm run dev"
kill_front:
	docker exec -ti ${PROJECT_NAME}-node sh -c "ps -ax | grep npm | awk '{print $$1}' | xargs kill -9"