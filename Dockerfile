# 3.4
FROM ruby@sha256:370e6be29a1cecbf44993087d2750e7d9e1570fde5b97c74325063b1750d11d0

EXPOSE 4567:4567
EXPOSE 35729:35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems
COPY ./Gemfile.lock /usr/src/gems

RUN apt-get update && apt-get install -y nodejs

RUN bundle config set force_ruby_platform true
RUN bundle install
RUN bundle check

WORKDIR /usr/src/docs

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
