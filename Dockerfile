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
  git \
  imagemagick \
  libffi-dev \
  libxml2-dev \
  nodejs \
  nodejs-npm \
  postgresql-dev \
  tzdata \
  xz-dev \
  zlib-dev

RUN adduser -h /srv/app -s /bin/sh -D app
WORKDIR /srv/app

ENV BUNDLE_JOBS=4 \
  BUNDLE_PATH=/srv/app/vendor \
  BUNDLE_BIN=/srv/app/vendor/bin \
  BUNDLE_APP_CONFIG=/srv/app/vendor/config \
  GEM_PATH=/srv/app/vendor:$GEM_PATH \
  PATH=/srv/app/bin:/srv/app/vendor/bin:$PATH

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json ./
RUN npm install

COPY . ./

RUN rake assets:precompile && \
  chown -R app:app ./tmp ./log

EXPOSE 3000
USER app
CMD rails s -b 0.0.0.0
