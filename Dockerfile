FROM registry.eorlbruder.de/nginx-php
MAINTAINER  David Magnus Henriques <eorlbruder@magnus-henriques.de>

RUN pacman -Syyu --noconfirm --quiet --needed libreoffice ffmpeg wget unzip && \
    pacman -Sc --noconfirm

RUN echo 'de_DE.UTF-8' > /etc/locale.gen
RUN locale-gen

WORKDIR /usr/share/webapps
RUN wget https://download.nextcloud.com/server/releases/latest.zip
RUN unzip latest.zip
RUN chown http:http -R nextcloud

# RUN rm -rf /srv/http
RUN ln -s /usr/share/webapps/nextcloud /srv/http/nextcloud
RUN chown -R http:http /usr/share/webapps/nextcloud
RUN chown -R http:http /srv/http

ADD assets/0-nextcloud.conf /etc/nginx/sites-available/0-nextcloud.conf

CMD ["supervisord", "-n"]
