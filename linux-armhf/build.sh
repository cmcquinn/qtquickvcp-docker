#!/usr/bin/env bash
docker build -t cmcquinn/qtquickvcp-docker-linux-armhf:latest -f ./Dockerfile . #--no-cache=true --rm=true .
