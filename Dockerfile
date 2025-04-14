# 3.4
FROM ruby@sha256:a4b78df1f33335b595524a16773e58bbb2ee08a8dc9d870cfbad15a6d286d0f6

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
