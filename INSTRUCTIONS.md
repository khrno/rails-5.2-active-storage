# Instructions

## Create the project

1. Generate docker image. To do that, you need to create a file called `Dockerfile` with the following content:

    ```dockerfile
    FROM ruby:2.5
    RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
    RUN mkdir /myapp
    WORKDIR /myapp
    COPY Gemfile /myapp/Gemfile
    COPY Gemfile.lock /myapp/Gemfile.lock
    RUN bundle install
    COPY . /myapp
    ```

1. Generate a Rails dependencies file. The content of this file will be replaced with the generated when we create the Rails Application. To create the Rails dependencies file, you need to create a file called `Gemfile` with the following content:

    ```gemfile
    source 'https://rubygems.org'
    gem 'rails', '5.2.0'
    ```

1. Create an empty file called `Gemfile.lock`. As the previously file, the content of this file will be replaced when the container is building.

1. Create an orchestration docker containers file called `docker-compose.yml`. This file will do all the magic to create the networking necessary between our Rails Application and services that need. This file must have the content:
    ```docker-compose
    version: '3'
    services:
      db:
        image: mysql:5.7
        volumes:
          - ./tmp/db:/var/lib/mysql
        environment:
          MYSQL_ROOT_PASSWORD: mysecurepassword
      web:
        build: .
        command: bundle exec rails s -p 3000 -b '0.0.0.0'
        volumes:
          - .:/myapp
        ports:
          - "3030:3000"
        depends_on:
          - db
    ```

1. To create a Rails application inside the container. For this, you run the following command:

    ```bash
    docker-compose run web rails new . --force --database=mysql
    ```
    This command may be take some time. First, it will be download the images which are necessary to build our stack such as `msyql:5.7` and `ruby:2.5` and then will be execute, line by line, the `Dockerfile` defined before.

1. Build the stack again with the new dependencies specified by the generated `Gemfile`.

1. Finnaly you need to configure the database configuration in your Rails Application. For example, in the file `config/database.yml` you need to add the `host: db` and the `password: mysecurepassword`

## Run the project

To run the project, execute the command:

```bash
docker-compose up
```

It can be possible that command fails because you don't have the database yet. To create the database in the container of mysql to need to execute:

```bash
docker-compose run web rake db:create
```

If you wanna run the project in a detached mode, you can add the flag `-d` to start the project:

```bash
docker-compose up -d
```

To watch the logs of both services you can execute

```bash
docker-compose logs
```

If you want to watch just the logs of rails application you can execute

```bash
docker-compose logs -f web
```

To stop the servers, you can execute

```bash
docker-compose stop
```

To destroy the containers, you can execute

```bash
docker-compose down
```