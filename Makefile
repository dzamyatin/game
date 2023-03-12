up:
	docker-compose -f ./docker-compose.yml up -d --remove-orphans
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
composer:
	docker exec -ti game-php-fpm sh -c "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\" \
&& php composer-setup.php && php -r \"unlink('composer-setup.php');\"; \
apt-get update && \
apt install -y git && \
cd /www && \
php ../composer.phar $(ARGS) \
"