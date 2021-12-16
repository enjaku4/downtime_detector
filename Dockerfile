FROM ruby:2.6

RUN apt-get update -qq && apt-get install -y postgresql-client wait-for-it

ENV DATABASE_HOST=db
ENV REDIS_HOST=redis
ENV DATABASE_CLEANER_ALLOW_REMOTE_DATABASE_URL=true

RUN mkdir /usr/src/downtime_detector
WORKDIR /usr/src/downtime_detector
