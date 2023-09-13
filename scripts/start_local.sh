#!/bin/bash

# Check for .env.development.local file
if [ ! -f "$(dirname "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )" )/static/.env.development.local" ]; then
    echo "Missing updated .env.development.local file in the static directory. The server may not function properly."
else
    cp "$(dirname "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )" )/static/.env.development.local" "$(dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"
fi

# Safely kill Rails server if exists
pids=$(lsof -i tcp:3000 -t)
if [ -n "$pids" ]; then
  kill -15 $pids
  sleep 2  # Wait for processes to terminate

  # If processes are still running, use kill -9
  if lsof -i tcp:3000 -t > /dev/null; then
    kill -9 $pids
  fi
fi

# Function to check if Ruby 3.2.2 is installed
check_ruby_version() {
  if rbenv versions --bare | grep -q '3.2.2'; then
    return 0
  elif rvm list strings | grep -q 'ruby-3.2.2'; then
    return 0
  else
    return 1
  fi
}

# Function to start Rails server with rbenv
start_with_rbenv() {
  export RBENV_VERSION=3.2.2
  bundle exec rails server -p 3000 -b 0.0.0.0 -d
  return $?
}

# Function to start Rails server with RVM
start_with_rvm() {
  source "$HOME/.rvm/scripts/rvm"
  bundle exec rails server -p 3000 -b 0.0.0.0 -d
  return $?
}

# Check if Ruby 3.2.2 is installed
if check_ruby_version; then
  echo "Ruby 3.2.2 is installed."
else
  echo "Ruby 3.2.2 is not installed. Do you want to install it? (y/n)"
  read answer
  if [ "$answer" == "y" ]; then
    if command -v rbenv > /dev/null; then
      rbenv install 3.2.2
    elif command -v rvm > /dev/null; then
      rvm install 3.2.2
    else
      echo "Neither rbenv nor RVM is installed. Exiting."
      exit 1
    fi
  else
    echo "Exiting."
    exit 1
  fi
fi

# Attempt to start with rbenv
start_with_rbenv

# Check if the start was successful
if [ $? -eq 0 ]; then
  echo "Successfully started with rbenv."
else
  echo "Failed to start with rbenv. Trying with RVM..."
  
  # Attempt to start with RVM
  start_with_rvm
  
  # Check if the start was successful
  if [ $? -eq 0 ]; then
    echo "Successfully started with RVM."
  else
    echo "Failed to start with both rbenv and RVM."
    exit 1
  fi
fi
