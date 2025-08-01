#! /bin/bash

set -e

if [ "$1" = "--help" ]; then
    echo "$0 [docker|podman]"
    exit 1
fi

ENGINE="$1"
if [ "$ENGINE" = "" ] ; then
    if command -v podman >/dev/null 2>&1; then
        echo "Podman detected, launching in podman."
        ENGINE="podman"
    elif command -v docker >/dev/null 2>&1; then
        echo "Docker detected, launching in docker."
        ENGINE="docker"
    fi
fi

if [ "$ENGINE" = "podman" ]
then
    podman build . --tag gds-way
    # We need to force middleman into polling mode due to this podman issue: https://github.com/containers/podman/discussions/19430
    podman run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -it gds-way bash -c "bundle exec --gemfile=/usr/src/gems/Gemfile middleman --watcher-force-polling server"
elif [ "$ENGINE" = "docker" ]
then
    docker build . --tag gds-way
    docker run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -it gds-way
else
    echo "Neither podman or docker detected, stopping."
    exit 1
fi
