UID = $(shell id -u)
GID = ${UID}

WORKDIR=src

ifdef version
  VERSION = =${version}
endif

ifdef workdir
  WORKDIR = ${workdir}
endif

create-project:
	docker run --rm --user ${UID}:${GID} -v ${PWD}:/app composer:latest composer create-project --prefer-dist laravel/laravel${VERSION} ${WORKDIR}
	cp docker-compose.yml ${WORKDIR}/docker-compose.yml
	mkdir ${WORKDIR}/.docker
	cp -r .docker/mysql ${WORKDIR}/.docker
	cp -r .docker/nginx ${WORKDIR}/.docker
	cp -r .docker/php ${WORKDIR}/.docker
	cp -r .docker/Makefile ${WORKDIR}
	sed -i 's/APP_NAME=Laravel/APP_NAME=${WORKDIR}/g' ${WORKDIR}/.env.example
	sed -i 's/DB_HOST=127.0.0.1/DB_HOST=mysql/g' ${WORKDIR}/.env.example
	sed -i 's/DB_PASSWORD=/DB_PASSWORD=secret/g' ${WORKDIR}/.env.example
	sed -i 's/DB_DATABASE=laravel/DB_DATABASE=${WORKDIR}/g' ${WORKDIR}/.env.example
	sed -i 's/laravel-test/${WORKDIR}-test/g' ${WORKDIR}/.docker/mysql/init/create-test-database.sql
	sed -i 's/CACHE_DRIVER=file/CACHE_DRIVER=redis/g' ${WORKDIR}/.env.example
	sed -i 's/QUEUE_CONNECTION=sync/QUEUE_CONNECTION=redis/g' ${WORKDIR}/.env.example
	sed -i 's/SESSION_DRIVER=file/SESSION_DRIVER=redis/g' ${WORKDIR}/.env.example
	sed -i 's/REDIS_HOST=127.0.0.1/REDIS_HOST=redis/g' ${WORKDIR}/.env.example
	@echo new application succsessfully created in ${WORKDIR} !
