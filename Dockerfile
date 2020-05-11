# Ruby image
FROM ruby:2.5.1-slim-stretch
# Define our app root path
ENV APP_HOME /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev=9.6* \
  postgresql-client \
  nodejs
# Set the working directory to /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy the current directory contents into the container at our app path
COPY . $APP_HOME
# Copy Gemfiles over to the app
COPY Gemfile* $APP_HOME/
RUN bundle install
# Clean up after gems are installed
RUN rm $APP_HOME/Gemfile*

# Clean up uncessary data generated during the setup
RUN apt-get remove -y wget \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/cache \
    /var/lib/log \
    /usr/share/doc \
    /usr/share/locale

# Add a script to be executed every time the container starts
COPY docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 3000
