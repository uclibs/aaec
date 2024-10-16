# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'

# Standard Library Enhancements
gem 'base64', '~> 0.2.0' # Handling Base64 encoding, explicitly included for upcoming Ruby version changes
gem 'bigdecimal' # Provides arbitrary-precision decimal floating-point arithmetic, being removed from Ruby in version 3.4.0
gem 'csv' # Ruby's standard CSV library, being removed from Ruby in version 3.4.0
gem 'drb' # Distributed Ruby, being removed from Ruby in version 3.4.0
gem 'mutex_m' # Required for activestorage, being removed from Ruby in version 3.4.0
gem 'rexml', '>= 3.3.6' # XML parsing library, addressing bundle audit issues

# Core Rails gems
gem 'actioncable', '~> 6.1.7.9'
gem 'actionmailer', '~> 6.1.7.9'
gem 'actionpack', '~> 6.1.7.9'
gem 'actiontext', '~> 6.1.7.9'
gem 'rails', '~> 6.1.7.9' # The Rails framework

# Server and Performance
gem 'puma', '>= 6.4.3' # A fast, multithreaded, and highly concurrent web server for Ruby/Rack applications

# Frontend and Styles
gem 'bootstrap', '~> 5.3.2' # Front-end framework for developing responsive, mobile-first projects
gem 'coffee-rails', '~> 5.0' # Integrates CoffeeScript with Rails
gem 'jsbundling-rails' # Manages JavaScript bundling with modern tools like Webpack or esbuild
gem 'sass-rails', '~> 6.0' # Use Sass for stylesheets
gem 'turbolinks', '~> 5' # Makes navigating your site faster by using AJAX to load only the HTML needed
gem 'uglifier', '>= 1.3.0' # Uses Uglifier as the compressor for JavaScript assets

# Authentication and Authorization
gem 'bcrypt_pbkdf' # A key derivation function for safely storing passwords
gem 'ed25519' # Ed25519 elliptic curve public-key signature system

# Additional Functionality
gem 'bootsnap', '>= 1.1.0', require: false # Reduces boot times through caching
gem 'dotenv-rails' # Loads environment variables from .env
gem 'jbuilder', '~> 2.12' # Used for building JSON structures in a builder-style syntax
gem 'jquery-rails' # Provides jQuery and the jQuery UJS driver for Rails
gem 'net-smtp' # Provides Simple Mail Transfer Protocol (SMTP) functionality for Ruby's Net::SMTP library
gem 'pagy', '~> 9.0' # Pagination library that is fast, lightweight, and flexible
gem 'truncato' # HTML truncation library for Ruby

# Windows specific timezone data
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] # Timezone data for Windows

group :development, :test do
  # Debugging tools
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Debugging tool for Ruby

  # Testing libraries
  gem 'brakeman' # Static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'bundler-audit' # Patch-level verification for Bundler dependencies
  gem 'factory_bot_rails' # A fixtures replacement with a straightforward definition syntax
  gem 'rails-controller-testing' # Adds missing helper methods for controller tests in Rails 5
  gem 'rspec_junit_formatter' # Outputs RSpec results in JUnit format
  gem 'rspec-rails' # RSpec for Rails 6+
  gem 'rubocop' # A Ruby static code analyzer and formatter
  gem 'simplecov', require: false # Code coverage analysis tool for Ruby
  gem 'sqlite3', '~> 1.7' # SQLite3 database adapter for ActiveRecord

  # Coverage and code analysis
  gem 'coveralls_reborn' # Provides Ruby API for Coveralls.io code coverage reporting
end

group :development do
  # Deployment tools using Capistrano
  gem 'capistrano', '~> 3.19.1', require: false # A remote server automation and deployment tool
  gem 'capistrano-bundler', '~> 2.1', require: false # Capistrano integration for Bundler
  gem 'capistrano-rails', '~> 1.4', require: false # Integrates Rails with Capistrano
  gem 'capistrano-rbenv', '~> 2.0' # Rbenv integration for Capistrano
  gem 'capistrano-rbenv-install', '~> 1.2.0' # Installs rbenv and Ruby using Capistrano

  # Development enhancers
  gem 'listen', '>= 3.0.5', '< 3.10' # File change listener, required for Spring watcher
  gem 'spring' # Preloads your application for faster testing and Rake task runs
  gem 'spring-watcher-listen', '~> 2.1.0' # Listens to file system events for Spring
  gem 'web-console', '>= 3.3.0' # An interactive console for Rails
end

group :test do
  # Adds support for Capybara system testing and Selenium WebDriver
  gem 'capybara', '>= 2.15' # Integration testing tool for rack-based web applications
  gem 'capybara-selenium', '~> 0.0.6' # Capybara extension for using Selenium WebDriver
  gem 'selenium-webdriver', '~> 4.23' # WebDriver for testing web applications
end

group :production do
  gem 'mysql2' # MySQL database adapter for ActiveRecord
  gem 'rb-readline' # Pure Ruby Readline implementation, needed to get the console working in production mode
end
