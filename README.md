# Emqttd Docker

This repository contains the [Dockerfile](src/Dockerfile) of EMQTTD, used by [Mainflux IoT
Platform][mainflux]. Before proceeding, please check the EMQTTD [official website][emqttd] for more
information about the project.

### Usage
To start up the container, execute the following commands inside the command line:

```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -it -p 1883:1883 -p 8083:8083 -p 18083:18083 emqttd
```

Broker's behavior can be customized through its configuration, and by adding plugins. To customize
the container, clients are required to mount the `config` and `plugins` volumes. The contents of
mounted directories are copied over into the broker's `etc` and `plugins` directory, respectively.
The following snippet shows how to build and start the container with the custom configuration:

```bash
git clone https://github.com/Mainflux/emqttd-docker.git && cd emqttd-docker
cd src
docker build -t emqttd .
docker run -it -p 1883:1883 -p 8083:8083 -p 18083:18083 -v [host config directory]:/etc/emqttd/config -v [host
plugins directory]:/etc/emqttd/plugins emqttd
```

**IMPORTANT**: to be able to load additional plugins, `plugins.list` file must be present inside the
`config` volume. The file should contain names of plugins to be loaded. It is up to clients to
ensure that the enlisted plugins are present in broker's `plugins` directory! For example, to load
the `emqttd_auth_http` plugin, the following terms must be met:

- download the plugin and put it into the volume directory
- edit the plugin configuration files to met your requirements
- provide `plugins.list` file with the following content:

    ```
    emqttd_auth_http
    ```

> Format of the `plugins.list` is line-separated list, i.e. one plugin per line

### Documentation
Development documentation can be found on our [wiki][mainflux-wiki].

### Community
#### Mailing list
[mainflux][mainflux-google] Google group

For quick questions and suggestions you can also use GitHub Issues.

#### IRC
[Mainflux Gitter][mainflux-gitter]

#### Twitter
[@mainflux][mainflux-twitter]

### License
[Apache License, version 2.0](LICENSE)

[emqttd]: http://emqtt.io
[mainflux]: https://github.com/Mainflux/mainflux
[mainflux-wiki]: https://github.com/Mainflux/mainflux/wiki
[mainflux-google]: https://groups.google.com/forum/#!forum/mainflux
[mainflux-gitter]: https://gitter.im/Mainflux/mainflux?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[mainflux-twitter]: https://twitter.com/mainflux
