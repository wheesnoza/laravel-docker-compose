WORKDIR=src
ifdef version
  VERSION = =${version}
endif
ifdef workdir
  WORKDIR = ${workdir}
endif
create-project:
	docker run --rm -v ${PWD}:/app 708u/composer:1.9.3 composer create-project --prefer-dist laravel/laravel${VERSION} ${WORKDIR}
	cp docker-compose.yml ${WORKDIR} \
		&& cp .docker/mysql .docker/${WORKDIR} \
		&& cp .docker/nginx .docker/${WORKDIR} \
		&& cp .docker/php .docker/${WORKDIR} \
		&& cp .docker/Makefile ${WORKDIR}
	sed -i '' 's/DB_HOST=127.0.0.1/DB_HOST=db/g' ${WORKDIR}/.env.example
	sed -i '' 's/DB_PASSWORD=/DB_PASSWORD=secret/g' ${WORKDIR}/.env.example
	sed -i '' 's/APP_NAME=Laravel/APP_NAME=${WORKDIR}/g' ${WORKDIR}/.env.example
	sed -i '' 's/DB_DATABASE=laravel/DB_DATABASE=${WORKDIR}/g' ${WORKDIR}/.env.example
	sed -i '' 's/laravel-test/${WORKDIR}-test/g' ${WORKDIR}/.docker/mysql/init/create-test-database.sql
	@echo new application succsessfully created in ${WORKDIR} !
