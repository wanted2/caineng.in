#!/bin/sh

docker build docker -t caineng.in

docker run --rm -it -v $(PWD):/src --name caineng caineng.in bash build_dev.sh