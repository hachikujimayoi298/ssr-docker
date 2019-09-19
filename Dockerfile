ARG ssr_archive=shadowsocksr-libev-2.5.3

FROM alpine:3.10.2 AS build
ARG ssr_archive
COPY rs_tmp /
RUN apk add --no-cache alpine-sdk gettext autoconf libtool automake asciidoc xmlto c-ares libev pcre-dev zlib-dev openssl-dev linux-headers && tar -xzf ${ssr_archive}.tar.gz && cd $ssr_archive && ./configure && sed -i -e 's/-Werror//g' src/Makefile* && make -j$(nproc)

FROM alpine:3.10.2
ARG ssr_archive
COPY --from=build /${ssr_archive}/src/ss-* /usr/local/bin/
RUN mv /usr/local/bin/ss-local /usr/local/bin/ssr-local && mv /usr/local/bin/ss-nat /usr/local/bin/ssr-nat && mv /usr/local/bin/ss-redir /usr/local/bin/ssr-redir && apk add --no-cache pcre shadowsocks-libev
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]