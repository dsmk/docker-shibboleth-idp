#!/bin/bash -x
#
# command to run/create a docker container with our special parameters
#
version="$(cat version)"
docker_image="idp-duo:$version"
docker_container="idp-duo"
extprefix="$(pwd)/external"

docker run \
  -d \
  -p 443:443 \
  -v "$extprefix/external-mount:/external-mount" \
  --name="$docker_container" \
  "$docker_image"
 
#  -v "$extprefix/logs:/opt/shibboleth-idp/logs" \
