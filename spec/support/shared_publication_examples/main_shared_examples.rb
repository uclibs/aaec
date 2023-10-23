# frozen_string_literal: true

require_relative 'create_spec'
require_relative 'index_spec'
require_relative 'show_spec'
require_relative 'new_spec'
require_relative 'edit_spec'
require_relative 'update_spec'
require_relative 'destroy_spec'

RSpec.shared_examples 'a standard publication controller' do |model_name, valid_params, invalid_params, new_params|
  it_behaves_like 'a publication with index action', model_name
  it_behaves_like 'a publication with create action', model_name, valid_params, invalid_params
  it_behaves_like 'a publication with show action', model_name
  it_behaves_like 'a publication with new action', model_name
  it_behaves_like 'a publication with edit action', model_name, valid_params, invalid_params, new_params
  it_behaves_like 'a publication with update action', model_name, valid_params, invalid_params, new_params
  it_behaves_like 'publication with destroy action', model_name
end
