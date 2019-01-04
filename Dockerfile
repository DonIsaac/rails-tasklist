FROM ruby:2.5
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libcurl4-openssl-dev libpq-dev nodejs net-tools
RUN mkdir /tasklist
WORKDIR /tasklist
COPY Gemfile /tasklist/Gemfile
COPY Gemfile.lock /tasklist/Gemfile.lock
# COPY vendor/gems /myappname/vendor/gems
RUN bundle install
COPY . /tasklist
EXPOSE 3000
# CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
CMD ["/tasklist/bin/rails", "server"]