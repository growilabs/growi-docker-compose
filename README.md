growi-docker-compose
=====================

Quick start [GROWI](https://github.com/growilabs/growi) with docker-compose

![GROWI-x-dockercompose](https://user-images.githubusercontent.com/1638767/38307565-105956e2-384f-11e8-8534-b1128522d68d.png)


Table of Contents
-----------------

1. [Start](#start)
1. [Upgrade](#upgrade)
1. [Migrate from crowi-plus-docker-compose](#migrate-from-crowi-plus-docker-compose)
1. [How to install plugins](#how-to-install-plugins)
1. [NOTE: DISABLED Environment Variables](#note-disabled-environment-variables)
1. [More convenient Examples](#more-convenient-examples)
1. [Documentation](#documentation)



Start
------

```bash
git clone https://github.com/growilabs/growi-docker-compose.git growi
cd growi
docker-compose up
```

and access to http://localhost:3000

### How to access from other than localhost

Edit `docker-compose.yml` and modify `ports` for app

#### Before

```yml
services:
  app:
    ports:
      - 127.0.0.1:3000:3000
```

#### After

```yml
services:
  app:
    ports:
      - 3000:3000
```

### For High-memory environment

If you have enough memory, increase heap size for Elasticsearch with `ES_JAVA_OPTS` value in `docker-compose.yml`.

```yml
environment:
  - "ES_JAVA_OPTS=-Xms2g -Xmx2g"
```

Upgrade
-------

### Check upgrading guide

Please be sure to access [Admin's guide - GROWI Docs](https://docs.growi.org/en/admin-guide/)([en](https://docs.growi.org/en/admin-guide/)/[ja](https://docs.growi.org/ja/admin-guide/)) and see 'Upgrade' section before upgrading. Sometimes you may have to deal with problems that may occur by yourself.


### Upgrading app container

```bash
# go to growi-docker-compose workdir
cd growi

# stop
docker compose stop

# remove current container and images
docker compose rm app

# update latest container image
git pull
docker compose pull

# start
docker compose up
```

Migrate from crowi-plus-docker-compose
---------------------------------------

If you have used [weseek/crowi-plus docker image](https://hub.docker.com/r/weseek/crowi-plus/) with docker-compose so far, please see [migration document](https://docs.growi.org/guide/migration-guide/from-crowi-plus-docker-compose.html).


NOTE: DISABLED Environment Variables
-------------------------------------

Followings are **unchangable**.

- PORT
- NODE_ENV

Followings are **disabled** because they are overwritten by `docker-compose.yml`

- MONGO_URI
- PASSWORD_SEED

Change `docker-compose.yml` if you need.

Others conform to [growilabs/growi](https://github.com/growilabs/growi#environment-variables)


More convenient Examples
-------------------------

* [Multiple sites](https://github.com/growilabs/growi-docker-compose/tree/master/examples/multi-app)
* [HTTPS(with Let's Encrypt) proxy integration](https://github.com/growilabs/growi-docker-compose/tree/master/examples/https-portal)
* [Backup MongoDB data](https://github.com/growilabs/growi-docker-compose/tree/master/examples/backup-mongodb-data)


Documentation
--------------

* [GROWI Docs](https://docs.growi.org/)
  
  
Issues
------

If you have any problems or questions about this image, please contact us through a [GitHub issue](https://github.com/growilabs/growi-docker-compose/issues).


License
---------

* The MIT License (MIT)
* See LICENSE file.