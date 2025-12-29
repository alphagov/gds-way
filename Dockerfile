# 3.4.7
FROM ruby@sha256:d86dccbc5b12a28c81dcabaf221a83deaeddb4235aa3f33786155db93f98604a

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
