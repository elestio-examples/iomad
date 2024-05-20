#!/usr/bin/env bash

sed -i "s~ARG ITOP_DOWNLOAD_URL~ARG ITOP_DOWNLOAD_URL=https://sourceforge.net/projects/itop/files/itop/3.0.2-1/iTop-3.0.2-1-9957.zip/download~g" Dockerfile
docker buildx build . --output type=docker,name=elestio4test/itop:latest | docker load
