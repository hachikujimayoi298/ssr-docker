#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    tag='latest'
    args="$@"
  else
    tag=$1
    args="${@:2}"
fi

docker build -t hachikujimayoi298/ssr-docker:$tag . $args
