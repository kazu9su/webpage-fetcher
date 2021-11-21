FROM ruby:3.0.2-alpine3.13

WORKDIR /app
RUN apk update && apk upgrade && \
    apk add --no-cache bash ruby-dev gcc musl-dev make build-base
RUN gem install unf_ext bundler
