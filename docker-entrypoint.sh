#!/usr/bin/env bash

echo "Removing potential pre-existing server.pid for Rails."
rm -f /app/tmp/pids/server.pid 

# Start rails server in development mode
echo 'Starting Rails Server'
bundle exec rails s -p 3000 -b 0.0.0.0