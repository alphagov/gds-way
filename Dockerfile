FROM ruby:4.0.6-slim@sha256:607bf92fa7ecebb4a0c6654b62cb44c48d94b36b6f5a754611ddbbe3dc5b6135

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
