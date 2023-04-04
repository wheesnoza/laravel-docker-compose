# Laravel dockerized develop environment.
### Build a dockerized laravel development environment.
# How to use
## Create new application
Clone a new laravel project with docker-compose settings.

```bash
$ git clone git@github.com:wheesnoza/laravel-docker-compose.git
$ cd laravel-docker-compose
$ make create-project
```

For default workdir name is `src` and the version is the latest version of laravel.
You can use `workdir` and `version` options to specific the name of your laravel application and the version.

```bash
$ make create-project workdir=your-new-laravel-app-name version=7.*
```

## Dockerize project
When your new laravel project is installed is necessary to make up docker-compose settings and containers.
You only have to do...

```bash
$ cd your-new-laravel-app-name
$ make init
```

And the necessary configurations will begin.
For default the db and test db name they are the same as the name of the project.
