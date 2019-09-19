# ssr-docker
A docker image for [ShadowsocksR](https://github.com/shadowsocksrr/shadowsocksr-libev)

This docker image accepts and executes whatever commands along with their arguments passed in via `docker run ssr-docker cmd args...`. The three executables `ssr-local`, `ssr-redir`, and `ssr-net` are located in `/usr/local/bin`. Besides, the `shadowsocks-libev` package from alpine package manager is also installed. Remeber to publish the relevant ports, and mount a volumn if you want to use a configuration file. If you want to tweak the image, run `docker run -it ssr-docker /bin/sh` to enter the shell.

## Examples
```sh
# Remember to use -b to override the local address to 0.0.0.0 and -l to override the local port to the published port on the host (1080 here)
docker run --rm -d -p 1080:1080 -v /path/to/config/files:/configs hachikujimayoi298/ssr-docker ssr-local -b 0.0.0.0 -l 1080 -c /configs/some_config.json
# open a shell
docker run -it hachikujimayoi298/ssr-docker /bin/sh
# run some arbitrary commands
docker run --rm hachikujimayoi298/ssr-docker echo "This is a docker image for shadowsocksR." 
```

The build process can be slow as it need to download the relevant dependencies and compiles the full C program in the container.

This docker images use the 2.5.3 release of [this version](https://github.com/shadowsocksrr/shadowsocksr-libev/tree/Akkariiin/master) of ShadowsocksR.

## License

Copyright (C) 2016 Max Lv max.c.lv@gmail.com

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
