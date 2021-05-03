FROM ruby:2.6.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client nano wait-for-it

ENV RAILS_ENV=development
ENV REDIS_URL=redis://redis:6379/0

RUN mkdir /downtime_detector
WORKDIR /downtime_detector
