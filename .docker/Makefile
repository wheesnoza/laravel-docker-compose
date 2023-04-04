include .env
up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
init:
	cp .env.example .env
	@make build
	@make up
	@make composer install
	docker-compose exec app pnpm install
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	@make migrate
reinit:
	@make destroy
	@make init
stop:
	docker-compose stop
down:
	docker-compose down
restart:
	@make down
	@make up
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
ps:
	docker-compose ps
migrate:
	docker-compose exec app php artisan migrate
seed:
	docker-compose exec app php artisan db:seed
fresh:
	docker-compose exec app php artisan migrate:fresh --seed
tinker:
	docker-compose exec app php artisan tinker
optimize:
	@make composer dump-autoload && \
    docker-compose exec app php artisan optimize:clear
appsh:
	docker-compose exec app /bin/sh
db:
	docker-compose exec mysql mysql -u$(DB_USERNAME) -p$(DB_PASSWORD) $(DB_DATABASE)
.PHONY: pnpm
ifeq (pnpm,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
pnpm:
	docker-compose exec app pnpm $(RUN_ARGS)

.PHONY: composer
ifeq (composer,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
composer:
	docker-compose exec app composer $(RUN_ARGS)
