FROM ruby:2.6.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client nano curl

ARG RAILS_MASTER_KEY
ARG CMD

ENV RAILS_ENV=production
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --without development test

COPY . .

RUN bundle exec rails assets:precompile

CMD $CMD
