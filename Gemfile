# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.7.7'
# gem 'sqlite3'

# Replaces Webpacker
gem 'jsbundling-rails'

# Use Puma as the app server
gem 'puma', '>= 6.3.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# gem 'coveralls', '~> 0.8.22', require: false
gem 'coveralls_reborn'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# gem 'rails-controller-testing'
# gem 'rubocop'
# gem 'simplecov', require: false
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 5.3.2'

gem 'bcrypt_pbkdf'
gem 'dotenv-rails'
gem 'ed25519'
gem 'jquery-rails'
gem 'net-smtp'
gem 'pagy', '~> 8.6.3'
gem 'truncato'

group :development, :test do
  gem 'brakeman', '~> 6.1'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov', require: false
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '~> 3.18.1', require: false
  gem 'capistrano-bundler', '~> 2.1', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.0' # required
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.10'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'capybara-selenium', '~> 0.0.6'
  gem 'selenium-webdriver', '~> 4.18.1'
end

group :production do
  gem 'mysql2'

  # Needed to get console working in production mode
  gem 'rb-readline'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
