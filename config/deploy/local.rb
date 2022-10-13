# frozen_string_literal: true

set :rails_env, :development
set :bundle_without, %w[production test].join(' ')
set :branch, 'update-rails'
set :default_env, path: '$PATH:/usr/local/bin'
append :linked_files, 'db/development.sqlite3'
append :linked_dirs, 'tmp', 'log', 'public/system'
ask(:username, nil)
ask(:password, nil, echo: false)
server 'localhost', user: fetch(:username), password: fetch(:password), port: 22, roles: %i[web app db]
set :deploy_to, '~/aaec'
before 'deploy:starting', 'shared_db'
after 'deploy:updating', 'init_qp'
before 'deploy:cleanup', 'start_local'
