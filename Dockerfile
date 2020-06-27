FROM flyingfeng/ruby2.1:latest

WORKDIR /usr/src/app

RUN gem install bcrypt-ruby -v '3.0.1'
RUN gem install json -v '1.8.0'
RUN gem install sqlite3 -v '1.3.7'
RUN gem install therubyracer -v '0.11.4'
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
