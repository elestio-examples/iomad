<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# IOMAD, verified and packaged by Elestio

A better community platform for the modern web.

[IOMAD](https://www.iomad.org/) the open-source multi-tenancy solution with Moodle under the hood. Scottish Gaelic for many, lots, various…

<img src="https://github.com/elestio-examples/iomad/raw/main/iomad.png" alt="iomad" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/iomad">fully managed iomad</a> on <a target="_blank" href="https://elest.io/">elest.io</a> For Securely Transfer and Store Your Files .

[![deploy](https://github.com/elestio-examples/iomad/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/iomad)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/iomad.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Run the project with the following command

    chmod +x ./scripts/preInstall.sh
    ./scripts/preInstall.sh
    docker-compose up -d
    chmod +x ./scripts/postInstall.sh
    ./scripts/postIstall.sh

You can access the Web UI at: `http://your-domain:48647`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"

    services:
        iomad:
            image: elestio4test/iomad:${SOFTWARE_VERSION_TAG}
            restart: always
            env_file:
                - ./.env
            links:
                - mysql:DB
            volumes:
                - ./moodleapp-data:/var/moodledata
                - ./php.ini:/etc/php/8.1/apache2/php.ini
                - ./config.php:/var/www/html/config.php
                - ./index.php:/var/www/html/admin/index.php
            depends_on:
                - mysql
            ports:
                - "172.17.0.1:48647:80"

        mysql:
            image: elestio/mysql:8.0
            restart: always
            command: mysqld --default-authentication-plugin=mysql_native_password --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max_connections=1000 --gtid-mode=ON --enforce-gtid-consistency=ON
            environment:
                - MYSQL_DATABASE=${MYSQL_DATABASE}
                - MYSQL_USER=${MYSQL_USER}
                - MYSQL_PASSWORD=${MYSQL_PASSWORD}
                - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
            volumes:
                - ./mysql:/var/lib/mysql
            ports:
                - "172.17.0.1:17956:3306"

        pma:
            image: elestio/phpmyadmin:latest
            restart: always
            links:
                - mysql:mysql
            ports:
                - "172.17.0.1:13779:80"
            environment:
            PMA_HOST: mysql
            PMA_PORT: 3306
            PMA_USER: root
            PMA_PASSWORD: ${ADMIN_PASSWORD}
            UPLOAD_LIMIT: 500M
            MYSQL_USERNAME: root
            MYSQL_ROOT_PASSWORD: ${ADMIN_PASSWORD}
            depends_on:
                - mysql

### Environment variables

|       Variable       |   Value (example)   |
| :------------------: | :-----------------: |
| SOFTWARE_VERSION_TAG |       latest        |
|     ADMIN_EMAIL      |   your@email.com    |
|    ADMIN_PASSWORD    |    your-password    |
|    MYSQL_DATABASE    |       moodle        |
|     DB_DATABASE      |       moodle        |
| MYSQL_ROOT_PASSWORD  |    your-password    |
|      MYSQL_USER      |       moodle        |
|       DB_USER        |       moodle        |
|    MYSQL_PASSWORD    |    your-password    |
|     DB_PASSWORD      |    your-password    |
|       DB_HOST        |        mysql        |
|       DB_PORT        |        3306         |
|      MOODLE_URL      | https://your.domain |
|      SSL_PROXY       |        true         |
|      SMTPHOSTS       | smtp-host:smtp-port |
|     SMTPAUTHTYPE     |        PLAIN        |
|    NOREPLYADDRESS    |  sender@email.com   |

# Maintenance

## Logging

The Elestio IOMAD Docker image sends the container logs to stdout. To view the logs, you can use the following command:

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

- <a target="_blank" href="https://github.com/iomad/iomad">IOMAD Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/iomad">Elestio/IOMAD Github repository</a>
