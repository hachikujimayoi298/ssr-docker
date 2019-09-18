# ssr-docker
A docker image for ShadowsocksR

This docker image accepts and executes whatever commands along with their arguments passed in via `docker run ssr-docker cmd args...`. The three executables `ss-local`, `ss-redir`, and `ss-net` are located in `/usr/local/bin`. Remeber to publish the relevant ports, and mount a volumn if you want to use a configuration file. If you want to tweak the image, run `docker run -it ssr-docker /bin/sh` to enter the shell.