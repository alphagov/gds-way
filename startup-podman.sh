#! /bin/bash

set -e

podman build . --tag gds-way

podman run --rm -p 4567:4567 -p 35729:35729 -v $(pwd):/usr/src/docs -it gds-way
