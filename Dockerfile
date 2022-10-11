FROM ruby:3.2.2-alpine3.19

RUN set -ex && apk add bash git ruby-dev build-base

RUN mkdir -p /app
WORKDIR /app
COPY src /app

RUN bundle
