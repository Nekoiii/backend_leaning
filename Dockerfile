FROM ruby:3.2.2

RUN apt-get update -qq

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle install --jobs=2

COPY . $APP_HOME
# ADD v.s COPY: https://www.cnblogs.com/zdz8207/p/linux-docker-add-copy.html

CMD ["bundle", "exec", "rails", "s", "-p", "3000"]