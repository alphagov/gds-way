#! /bin/bash

set -e

if command -v podman >/dev/null 2>&1
then
    echo "Podman detected, launching in podman."
    podman build . --tag gds-way
    podman run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -e RUBYOPT="-r/usr/src/docs/patches/patch_listen.rb" -it gds-way
elif command -v docker >/dev/null 2>&1
then
    echo "Docker detected, launching in docker."
    docker build . --tag gds-way
    docker run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -it gds-way
else
    echo "Neither podman or docker detected, stopping."
    exit 1
fi
