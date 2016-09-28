# Emqttd Docker

### About
Dockerfile and containerization procedure for [emqttd](http://emqtt.io/) - Erlang MQTT broker.

Used by [Mainflux IoT Platform](https://github.com/Mainflux/mainflux).

### Install/Deploy
```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -i -t -p 1883:1883 -p 18083:18083 emqttd
```

### Documentation
Development documentation can be found on our [Mainflux GitHub Wiki](https://github.com/Mainflux/mainflux/wiki).

### Community
#### Mailing list
[mainflux](https://groups.google.com/forum/#!forum/mainflux) Google group

For quick questions and suggestions you can also use GitHub Issues.

#### IRC
[Mainflux Gitter](https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

#### Twitter
[@mainflux](https://twitter.com/mainflux)

### License
[Apache License, version 2.0](LICENSE)
