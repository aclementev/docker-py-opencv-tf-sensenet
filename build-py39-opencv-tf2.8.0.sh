#!/bin/bash
set -exo pipefail

build-macm1() {
    DOCKER_BUILDKIT=1 docker build --platform linux/amd64 -t clementebigml/python-opencv-tf:py39-cv4.5.5-tf2.8.0-arm64 --build-arg FORAARCH64=1 -f Dockerfile-py39-opencv-tf2.8.0 .
}


build-others() {
    DOCKER_BUILDKIT=1 docker build --platform linux/amd64 -t clementebigml/python-opencv-tf:py39-cv4.5.5-tf2.8.0-amd64 --build-arg FORAARCH64=0 -f Dockerfile-py39-opencv-tf2.8.0 .
}

if [ $1 = "--m1" ]; then
    echo "Building images targeting mac M1 execution"
    build-macm1
else
    echo "Building images targeting x64 processors"
    build-others
fi
