# frozen_string_literal: true

set :rails_env, :production
set :bundle_without, %w[development test].join(' ')
set :branch, 'qa'
set :default_env, path: '$PATH:/usr/local/bin'
set :bundle_path, -> { shared_path.join('vendor/bundle') }
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
append :linked_dirs, 'tmp', 'log'
ask(:username, nil)
ask(:password, nil, echo: false)
server 'libappstest.libraries.uc.edu', user: fetch(:username), password: fetch(:password), port: 22, roles: %i[web app db]
set :deploy_to, '/opt/webapps/aaec'
after 'deploy:updating', 'ruby_update_check'
after 'deploy:updating', 'init_qp'
before 'deploy:cleanup', 'start_qp'
