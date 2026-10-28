FROM ruby:4.0.8-slim@sha256:55d1710ff7d36fc88ce792c45b5e04145590c29ba220fb5f1e412b90766b19bf

EXPOSE 4567
EXPOSE 35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y --no-install-recommends nodejs build-essential curl git ca-certificates && rm -rf /var/lib/apt/lists/*

RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

ENV APP_ENV=docker

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
