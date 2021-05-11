FROM ruby:2.6.7

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN mkdir /usr/src/downtime_detector
WORKDIR /usr/src/downtime_detector
