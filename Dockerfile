# 4.0.5-alpine3.22
FROM ruby@sha256:8578890de8017767b1df03979c1f8fe42152aaf83a51ad44d4f215319c200d1b

EXPOSE 4567
EXPOSE 35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y nodejs build-essential curl

RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

ENV APP_ENV=docker

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
