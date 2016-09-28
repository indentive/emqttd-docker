# Emqttd Docker

This repository contains the [Dockerfile](src/Dockerfile) of Emqttd used by [Mainflux IoT
Platform][2]. Before proceeding, please check the Emqttd's [official website][1] for more
information about the project.

### Usage
To start up the container, execute the following commands inside the command line:

```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -i -t -p 1883:1883 -p 18083:18083 emqttd
```

### Documentation
Development documentation can be found on our [Mainflux GitHub Wiki][3].

### Community
#### Mailing list
[mainflux][4] Google group

For quick questions and suggestions you can also use GitHub Issues.

#### IRC
[Mainflux Gitter][5]

#### Twitter
[@mainflux][6]

### License
[Apache License, version 2.0](LICENSE)

[1]: http://emqtt.io
[2]: https://github.com/Mainflux/mainflux
[3]: https://github.com/Mainflux/mainflux/wiki
[4]: https://groups.google.com/forum/#!forum/mainflux
[5]: https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[6]: https://twitter.com/mainflux
