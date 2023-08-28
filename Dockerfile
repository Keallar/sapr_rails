FROM ruby:3.1.2 as builder

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1

RUN yarn add esbuild
RUN yarn add sass

ENV APP_APTH=/usr/src
WORKDIR $APP_APTH

ADD Gemfile $APP_APTH/Gemfile
ADD Gemfile.lock $APP_APTH/Gemfile.lock

RUN yarn install

RUN bundle install