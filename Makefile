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