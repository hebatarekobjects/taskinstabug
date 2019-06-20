FROM ruby:2.5.0

# RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
# RUN apt-get install aptitude
RUN apt-get update -qq 
# RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev nodejs

RUN mkdir /instabug
WORKDIR /instabug

ADD Gemfile /instabug/Gemfile
ADD Gemfile.lock /instabug/Gemfile.lock

RUN bundle install

ADD . /instabug