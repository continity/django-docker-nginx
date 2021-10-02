FROM nginx:latest

LABEL maintainer="contact@continity.io"

ENV PROJECT_NAME=django
ENV PROJECT_DOCKER_DIR=/var/www/django

COPY ./default.conf.tpl /etc/nginx/conf.d/django.conf
COPY ./start.sh /start.sh

RUN apt-get update --fix-missing && \
    apt-get install -y curl vim --no-install-recommends && \
    apt-get clean && \
    chmod 775 /start.sh

EXPOSE 80
WORKDIR /var/www

ENTRYPOINT ["sh", "/start.sh"]
