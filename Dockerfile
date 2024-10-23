# 3.1.3-buster
FROM ruby@sha256:55cd5fab4140db7a04f46921eafcd941be95f6c5687b01154d43e75479ba0fe9 

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
