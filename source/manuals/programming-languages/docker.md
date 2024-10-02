---
title: Dockerfile guidance
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2023-03-22
review_in: 6 months
permalink: manuals/programming-languages/docker.html

---

This style guide:

* provides some conventions for creating production-ready Dockerfiles at GDS
* supplements the official [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

## Using tags and digests in FROM instructions

The `FROM` instruction specifies the starting image for your Docker image build.

A tag is a short label you can use to reference an image.

For example:

```
FROM alpine:3.9
```

where:

* `alpine` is the image name
* `3.9` is the tag

As you cannot rely on the tag pointing to the exact same image over time, you
should instead use a digest, which identifies the image by a hash of its
contents. This makes sure that you are always referencing the image that you
expect.

For example:

```
FROM alpine@sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6
```

Where `sha256@769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6`
is the unique digest representing the particular variant of the image.

To get the digest, run `docker pull <tag>`. For example:

```
$ docker pull alpine:3.9
3.9: Pulling from library/alpine
Digest: sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6
Status: Image is up-to-date for alpine:3.9
```

As [Dependabot](https://dependabot.com) has [support for updating `FROM` lines
which use digests](https://github.com/dependabot/dependabot-core/pull/100),
you can still use Dependabot to keep your images up-to-date.

## Using multi-stage builds

Using [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/) enables the drastic
reduction of image sizes, which in turn decreases the time taken to launch the container. There can be many stages
within a Dockerfile. The result is a single layer image which discards the previous unrequired layers that were
used in the compilation steps.

As an example;

```
FROM golang:1.16 AS builder
WORKDIR /go/src/github.com/alphagov/paas-aiven-broker/
RUN git clone https://github.com/alphagov/paas-aiven-broker.git .
RUN go mod download
RUN go build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/alphagov/paas-aiven-broker/paas-aiven-broker .
COPY --from=builder /go/src/github.com/alphagov/paas-aiven-broker/paas-aiven-broker/examples/config.json .
CMD ["./paas-aiven-broker", "-config", "config.json"]
```

Building from this Dockerfile requires no changes to the existing build process e.g. `docker build -t myimage:latest .`

It is also possible to stop the build at a specific stage using a command such as
`docker build --target builder -t myimage:development .` which then enables running the container locally to debug the image.

## Running programs as process ID (PID) 1

The program running as PID 1 inside a container is responsible for:

* cleaning up orphaned child processes
* handling signals
* returning the exit status from the container

Most programs are unsuited to running as PID 1 inside a container. For
example:

* `bash` will not pass signals through to its children; for example, `SIGTERM` will
  not lead to the container being shut down
* `java` exits with an exit status of 143 when sent a SIGTERM, even if the application shuts
  down cleanly
* `node` does not reap orphaned child processes whose parent has exited

[Tini](https://github.com/krallin/tini) provides a program suitable for
running as PID 1 inside the container. You can use Tini to avoid the problems
highlighted above. Tini is included by default with the Docker runtime or
Alpine Linux images.

You can use `tini` by passing the `--init` option to Docker when running your
container or set Tini as the `ENTRYPOINT` for your container. For example:

```
ENTRYPOINT ["tini", "--"]
```

or for Java programs, to map an exit status of 143 to 0:

```
ENTRYPOINT ["tini", "-e", "143", "--"]
```

## Subshells

The instructions `RUN`, `CMD` and `ENTRYPOINT` have 2 forms:

* freeform text (for example `CMD “run -x”`)
* an array-style (for example `CMD [“run”, “-x”]`)

You should use the array-style syntax where possible.

A Linux syscall will directly execute all commands specified using the
array-style syntax, without an enclosing subshell. This process is more
efficient and removes any ambiguity over how the commands will be interpreted.

In the case of `ENTRYPOINT` or `CMD`, using the freeform text syntax means that
a shell becomes PID 1 and most programs should not run as PID 1, as explained
above.

For more information about the special role of PID 1:

* [avoid running NodeJS as PID 1 under Docker images](https://www.elastic.io/nodejs-as-pid-1-under-docker-images/)
* [docker-node best practices - Handling Kernel Signals](https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#handling-kernel-signals)
* [Docker and the PID 1 zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/)

## Links

 * A smarter [Dockerfile linter](https://github.com/hadolint/hadolint) that helps you build best practice Docker images
 * `conftest` policy to [validate the label rules](https://github.com/deanwilson/opa-policies#gdsway-dockerfile)
