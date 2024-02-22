# AAEC (Artists, Authors, Editors & Composers)

![CircleCI](https://img.shields.io/circleci/build/github/uclibs/aaec)

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites
```
Ruby Version 3.3.0
SQLite 3
```

## Installing
1. Clone the repository: `git clone https://github.com/uclibs/aaec.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Make sure you are on the qa branch: `git checkout qa`
1. Install bundler (if needed): `gem install bundler`
1. Run bundler: `bundle install`
1. Run the database migrations: `bundle exec rake db:migrate`
1. To include the colleges at UC, seed the database: `bundle exec rake db:seed`
1. Start the rails server: `rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)

## Running the tests
1. Run the database migrations: ```bundle exec rake db:migrate``` (Optional)
1. Run the test suite: ```bundle exec rspec```

## Note on Dependency Management
While this repository includes a yarn.lock file, you do not need to run yarn install to use the program. 
The application is fully operational with bundle install alone, which manages all necessary Ruby 
dependencies.