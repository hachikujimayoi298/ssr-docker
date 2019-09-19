FROM alpine AS build
ARG ssr_archive=shadowsocksr-libev-2.5.3
ARG ss_archive=shadowsocks-libev-3.3.1
COPY rs_tmp /
RUN apk add --update alpine-sdk openssl-dev gettext autoconf libtool automake asciidoc xmlto c-ares-dev libev-dev pcre-dev zlib-dev linux-headers mbedtls-dev libsodium-dev
RUN for f in *.tar.gz; do tar -xf "$f"; done
WORKDIR /${ssr_archive} 
RUN ./configure --disable-documentation --with-crypto-library=openssl
RUN sed -i -e 's/-Werror//g' src/Makefile* 
RUN make -j$(nproc)
WORKDIR /${ss_archive}
RUN ./configure --disable-documentation
RUN make -j$(nproc)
WORKDIR / 
RUN mkdir out \ 
 && cp /${ssr_archive}/src/ss-local /out/ssr-local \ 
 && cp /${ssr_archive}/src/ss-nat /out/ssr-nat \ 
 && cp /${ssr_archive}/src/ss-redir /out/ssr-redir \
 && cp /${ss_archive}/src/ss-* /out/ 

FROM alpine
COPY --from=build /out/* /usr/local/bin/
RUN apk add --update --no-cache libev openssl libsodium mbedtls pcre $(scanelf --needed --nobanner /usr/bin/ss-* | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' | sort -u)
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]