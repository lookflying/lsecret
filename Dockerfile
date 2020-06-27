FROM ruby:2.5.1-alpine

ENV BUNDLER_VERSION=2.0.2

RUN set -eux; \
    apk add --no-cache --virtual \
        ruby-dev \
        sqlite-dev \
        binutils-gold \
        build-base \
        curl \
        file \
        g++ \
        gcc \
        git \
        less \
        libstdc++ \
        libffi-dev \
        libc-dev \ 
        linux-headers \
        libxml2-dev \
        libxslt-dev \
        libgcrypt-dev \
        make \
        netcat-openbsd \
        nodejs \
        openssl \
        pkgconfig \
        postgresql-dev \
        python \
        tzdata \
        yarn 

RUN gem install bundler -v 2.0.2

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
