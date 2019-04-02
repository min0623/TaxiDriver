FROM ruby:2.6.2

RUN apt-get update -qq && apt-get install -y build-essential nodejs mysql-client vim

RUN mkdir /app

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . /app
WORKDIR /app
RUN RAILS_ENV=development bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]