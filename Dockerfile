FROM ruby:2.2.2-wheezy

MAINTAINER sllt<long@programmer.love>

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG en_US.UTF-8
RUN mkdir -p /usr/src/app

RUN apt-get update && apt-get install --force-yes -y memcached imagemagick

COPY . /usr/src/app
WORKDIR /usr/src/app

# install required gem
RUN bundle install

# compile assets
RUN bundle exec rake assets:procompile


# migrate database 
RUN bundle exec rake db:migrate

