ARG ssr_archive=shadowsocksr-libev-2.5.3

FROM alpine:3.10.2 AS build
ARG ssr_archive
RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache gettext autoconf libtool automake asciidoc xmlto c-ares libev pcre-dev zlib-dev openssl-dev linux-headers
COPY rs_tmp /
RUN tar -xzf ${ssr_archive}.tar.gz
WORKDIR $ssr_archive
RUN ./configure
RUN sed -i -e 's/-Werror//g' src/Makefile*
RUN make -j$(nproc)

FROM alpine:3.10.2
ARG ssr_archive
COPY --from=build /${ssr_archive}/src/ss-* /usr/local/bin/
COPY ./docker-entrypoint.sh /
RUN apk add --no-cache pcre
ENTRYPOINT ["/docker-entrypoint.sh"]