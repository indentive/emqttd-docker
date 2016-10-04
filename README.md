# Emqttd Docker

This repository contains the [Dockerfile](src/Dockerfile) of Emqttd used by [Mainflux IoT
Platform][1]. Before proceeding, please check the Emqttd's [official website][2] for more
information about the project.

### Usage
To start up the container, execute the following commands inside the command line:

```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -it -p 1883:1883 -p 8083:8083 -p 18083:18083 emqttd
```

Broker's behavior can be customized via editing its configuration and/or adding plugins. In both
ways, clients are required to mount the `config` and `plugins` volumes. The contents of mounted
directories are copied over into the broker's `etc` and `plugins` directory, respectively. The
following snippet shows how to build and start the container with the custom configuration:

```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -it -p 1883:1883 -p 8083:8083 -p 18083:18083 -v [host config directory]:/etc/emqttd/config -v [host
plugins directory]:/etc/emqttd/plugins emqttd
```

Please consult the [official website][2] to find out more about broker's configuration and available
plugins.

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

[1]: https://github.com/Mainflux/mainflux
[2]: http://emqtt.io
[3]: https://github.com/Mainflux/mainflux/wiki
[4]: https://groups.google.com/forum/#!forum/mainflux
[5]: https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[6]: https://twitter.com/mainflux
