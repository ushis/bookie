FROM alpine:3.6

RUN apk add --no-cache \
  ruby \
  ruby-bigdecimal \
  ruby-bundler \
  ruby-dev \
  ruby-io-console \
  ruby-irb \
  ruby-json \
  build-base \
  imagemagick \
  libffi-dev \
  libxml2-dev \
  nodejs \
  postgresql-dev \
  tzdata \
  xz-dev \
  zlib-dev

RUN adduser -h /home/app -s /bin/bash -D app

RUN mkdir /home/app/src /home/app/data
WORKDIR /home/app/src

ENV BUNDLE_JOBS=4 \
  BUNDLE_PATH=/home/app/bundle \
  BUNDLE_BIN=/home/app/bundle/bin \
  BUNDLE_APP_CONFIG=/home/app/bundle/config \
  GEM_PATH=/home/app/bundle:$GEM_PATH \
  PATH=/home/app/bundle/bin:$PATH

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . ./
RUN chown -R app:app /home/app

EXPOSE 3000

USER app
CMD rails s -b 0.0.0.0
