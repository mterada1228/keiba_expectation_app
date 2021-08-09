#
# syntax=docker/dockerfile:1
FROM ruby:2.5.3
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs mariadb-client yarn
WORKDIR /keiba_expectation_app
COPY Gemfile /keiba_expectation_app/Gemfile
COPY Gemfile.lock /keiba_expectation_app/Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN bundle install
COPY . /keiba_expectation_app
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 4000

# Configure the main process to run when running the image
RUN yarn install --check-files
RUN yarn webpack --config ./config/webpack/development.js

CMD ["rails", "server", "-b", "0.0.0.0"]