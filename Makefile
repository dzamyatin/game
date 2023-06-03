dev:
	make -s cert
	make -s authority
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
	docker exec -ti game-php-fpm bash
dnginx:
	docker exec -ti game-nginx bash
lphp:
	docker logs -f game-php-fpm
lnginx:
	docker logs -f game-nginx
cert:
	openssl req -x509 -newkey rsa:4096 -keyout nginx/key.pem -out nginx/cert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=localhost"
	echo "\n\n-------\n Add cert to authority `pwd`/nginx/cert.pem >> /etc/ssl/certs/ca-certificates.crt \n--------\n"
authority:
	sudo sh -c "rm -f /usr/local/share/ca-certificates/game-local*.crt | cp ./nginx/cert.pem /usr/local/share/ca-certificates/game-local`date +%s`.crt && update-ca-certificates"
composer:
	docker exec -ti game-php-fpm sh -c "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\" \
&& php composer-setup.php && php -r \"unlink('composer-setup.php');\"; \
apt-get update && \
apt install -y git && \
cd /www && \
php ../composer.phar $(ARGS)"