<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# iTop, verified and packaged by Elestio

A better community platform for the modern web.

[iTop](https://github.com/Combodo/iTop) is a complete open source and web-based IT service management platform, including a fully customizable CMDB, a helpdesk system, and a document management tool.

<img src="https://github.com/elestio-examples/itop/raw/main/itop.png" alt="itop" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/itop">fully managed itop</a> on <a target="_blank" href="https://elest.io/">elest.io</a> For Securely Transfer and Store Your Files .

[![deploy](https://github.com/elestio-examples/itop/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/itop)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/itop.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:8282`

## Docker-compose

Here are some example snippets to help you get started creating a container.

      
    version: "3.3"
    services:
    db:
        image: elestio/mysql:8.0
        restart: always
        stdin_open: true
        ports:
        - "172.17.0.1:40702:3306"
        environment:
        - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
        - MYSQL_DATABASE=${ITOP_DB_NAME}
        - MYSQL_USER=${ITOP_DB_USER}
        - MYSQL_PASSWORD=${ITOP_DB_PASS}
        volumes:
        - ./storage/mysql:/var/lib/mysql

    itop:
        image: elestio4test/itop:${SOFTWARE_VERSION_TAG}
        restart: always
        stdin_open: true
        environment:
        - ITOP_DB_HOST=${ITOP_DB_HOST}
        - ITOP_DB_NAME=${ITOP_DB_NAME}
        - ITOP_DB_USER=${ITOP_DB_USER}
        - ITOP_DB_PASS=${ITOP_DB_PASS}
        - PHP_ENABLE_UPLOADS=${PHP_ENABLE_UPLOADS}
        - PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT}
        - PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE}
        - PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE}
        - PHP_MAX_FILE_UPLOADS=${PHP_MAX_FILE_UPLOADS}
        - PHP_MAX_INPUT_TIME=${PHP_MAX_INPUT_TIME}
        - PHP_LOG_ERRORS=${PHP_LOG_ERRORS}
        - PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING}
        links:
        - db
        ports:
        - "172.17.0.1:8282:80"
        volumes:
        - ./storage/itop/conf:/var/www/itop/conf
        - ./storage/itop/data:/var/www/itop/data
        - ./storage/itop/log:/var/www/itop/log
        - ./storage/itop/env-production:/var/www/itop/env-production
        - ./storage/itop/env-production-build:/var/www/itop/env-production-build
        - ./storage/extensions:/var/www/itop/extensions

    pma:
        image: phpmyadmin
        restart: always
        links:
        - db:db
        ports:
        - "172.17.0.1:8111:80"
        environment:
        PMA_HOST: db
        PMA_PORT: 3306
        PMA_USER: root
        PMA_PASSWORD: ${ADMIN_PASSWORD}
        UPLOAD_LIMIT: 500M
        MYSQL_USERNAME: root
        MYSQL_ROOT_PASSWORD: ${ADMIN_PASSWORD}
        depends_on:
        - db



### Environment variables

|         Variable          |    Value (example)    |
| :-----------------------: | :-------------------: |
| SOFTWARE_VERSION_TAG      |     latest            |
| ADMIN_EMAIL               |     <YOUR_EMAIL>      |
| ADMIN_PASSWORD            |     <ADMIN_PASSWORD>  |
| MYSQL_ROOT_PASSWORD       |     <DB_PASSWORD>     |
| ITOP_DB_NAME              |     itop              |
| ITOP_DB_USER              |     itop              |
| ITOP_DB_PASS              |     <DB_PASS>         |
| ITOP_DB_HOST              |     db                |
| PHP_ENABLE_UPLOADS        |     On                |
| PHP_MEMORY_LIMIT          |     256M              |
| PHP_POST_MAX_SIZE         |     10M               |
| PHP_UPLOAD_MAX_FILESIZE   |     8M                |
| PHP_MAX_FILE_UPLOADS      |     20                |
| PHP_MAX_INPUT_TIME        |     300               |
| PHP_LOG_ERRORS            |     On                |
| PHP_ERROR_REPORTING       |     E_ALL             |

# Maintenance

## Logging

The Elestio iTop Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Combodo/iTop">iTop documentation</a>

- <a target="_blank" href="https://www.itophub.io/wiki/page">iTop Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/itop">Elestio/iTop Github repository</a>