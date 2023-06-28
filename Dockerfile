FROM ruby:3.0.6-buster

EXPOSE 4567:4567
EXPOSE 35729:35729

WORKDIR /usr/src/gems

COPY ./Gemfile /usr/src/gems

RUN apt-get update && apt-get install -y nodejs

ENV BUNDLE_FORCE_RUBY_PLATFORM=true
RUN bundle check || bundle install

WORKDIR /usr/src/docs

CMD [ "bundle", "exec", "--gemfile=/usr/src/gems/Gemfile", "middleman", "server" ]
