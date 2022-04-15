# The code below is mostly copied from:
# https://sqlite.org/althttpd/file?name=contrib/docker/Dockerfile.althttpd
ARG repoUrl=https://sqlite.org/althttpd
ARG version=trunk
ARG target=althttpd
FROM alpine:edge AS builder

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
      curl \
      gcc \
      make \
      musl-dev \
      openssl-dev \
      openssl-libs-static \
      zlib-dev \
      zlib-static

ARG repoUrl
ARG version
ARG target
ENV archive=althttpd-src.tar.gz
RUN curl -s -L -o althttpd-src.tar.gz \
      "${repoUrl}/tarball/${archive}?name=althttpd-src&uuid=${version}" \
      && tar xf ${archive} \
      && cd althttpd-src \
      && make static-${target} \
      && strip ${target}

RUN echo 'www:www:1000:1000:www:/www' > passwd

ARG target=althttpd
FROM scratch as ship

ARG target
COPY --from=builder /althttpd-src/${target} /althttpd
COPY --from=builder /passwd /etc/passwd

USER www

WORKDIR /www

ENTRYPOINT ["/althttpd", \
            "-port", "8080", \
            "-root", "/www"]

EXPOSE "8080"
