# 3.4.8-slim-bookworm
FROM ruby@sha256:66302616aabd939350e9bd7bc31ccad5ef993a5ba5e93f0cc029bb82e80a8d3b

EXPOSE 4567
EXPOSE 35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y nodejs

RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

ENV APP_ENV=docker

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
