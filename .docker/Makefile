up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
init:
	cp .env.example .env
	@make build
	@make up
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan storage:link
	@make restart
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

.PHONY: npm
ifeq (npm,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
npm:
	docker-compose run --rm npm $(RUN_ARGS)

.PHONY: composer
ifeq (composer,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
composer:
	docker-compose run --rm composer $(RUN_ARGS)
