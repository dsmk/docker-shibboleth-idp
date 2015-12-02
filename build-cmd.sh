#!/bin/bash -x
# 
# Build a new version of the image
#
version="$(cat version)"
docker build -t "idp-duo:$version" .
