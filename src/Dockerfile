FROM debian:jessie
MAINTAINER Mainflux

COPY docker-build.sh /
RUN sh docker-build.sh && rm docker-build.sh

EXPOSE 1883 8083 8883 18083
VOLUME /etc/emqttd/config /etc/emqttd/plugins

WORKDIR /opt/emqttd
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["emqttd", "foreground"]
