# "django-docker-nginx" Docker image
## Purpose
This generates a Docker Image to be included in docker-compose together with Django (Gunicorn) and Database (e.g. Postgresql).
Nginx forwards any request to the Django container, while the media and static files are served from Nginx.
## Usage
### Requirements
It should be used together with a django application image which fulfills the following requirements:
* Service to be called "web"
* Should use the Port 8000
This image does not implement SSL, as it is to be used behind a suitable proxy (e.g. traefik).
### How to use
The docker image can be retrieved from Docker Hub.

It should be embedded in a docker-compose file, with the following configuration:

```
version: "3"

services:
  web:
    # Place your web (Django App) config here
    
  postgres:
    # Place your database container config here

  nginx:
    restart: always
    image: tkneuss/django-docker-nginx:latest
    ports:
      - "8080:8080"
    volumes:
      - web-static:/var/www/django/static
      - web-media:/var/www/django/media
    networks:
      - traefik_default
    depends_on:
      - web


volumes:
  web-static:
  web-media:
```
