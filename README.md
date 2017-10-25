# para
Dockerized Para

## Use

```console
$ docker run --rm -e PARA_ENV=production para/latest
```

see also [Para docs](http://paraio.org/docs/).

## Use plugins

To install plugins you would make a text file that be separetaed by a colon.

```
para-dao-mongodb:1.25.2
```

Save above text as plugins.txt and build new image using it:

```
FROM para

ADD plugins.txt /tmp/
RUN plugin_install /tmp/plugins.txt
```

## Backup and restore

TODO
