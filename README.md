# `althttpd` docker

A tiny docker image `FROM scratch` running a _static_ build of [`althttpd`](https://sqlite.org/althttpd).

## Build

Build the [latest](https://sqlite.org/althttpd/info?name=trunk) version:

```bash
make
```

This will create an image named `althttpd:latest`.

### With TLS support

Set `TLS` to any value:

```bash
make TLS=1
```

This will set the name to `althttpsd:latest`.
To control the name of the image use the `NAME` variable.

### From a particular _Check-in_

Use a hash like [0a03b61432d41837](https://sqlite.org/althttpd/info/0a03b61432d41837):

```bash
make CHECKIN=0a03b61432d41837
```

The image is then named `althttpd:0a03b61432d41837`.

## Use

Publish a given directory:

```bash
make run DIR=/path/to/content
```

See the content at [http://localhost:8080](http://localhost:8080).
The port can be customized using the `PORT` variable.

### Examples

With logging:

```bash
docker run --rm \
  --publish 8080:8080 \
  --volume $(pwd)/index.html:/www/index.html \
  --volume $(pwd)/site.log:/site.log \
  althttpd:latest -logfile /site.log
```

## Acknowledgement

Previous work & inspiration:

- [_A tiny Docker image to serve static websites_ (HN post)](https://news.ycombinator.com/item?id=31003395)
- [`contrib/docker`](https://sqlite.org/althttpd/dir?ci=tip&name=contrib/docker) of `althttpd`
