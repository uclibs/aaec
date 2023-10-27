# frozen_string_literal: true

RSpec.shared_examples 'a standard publication controller' do |params|
  model_name = params[:model_name]
  valid_params = params[:valid_params]
  invalid_params = params[:invalid_params]
  new_params = params[:new_params]

  it_behaves_like 'a publication with index action', model_name
  it_behaves_like 'a publication with create action', model_name, valid_params, invalid_params
  it_behaves_like 'a publication with show action', model_name
  it_behaves_like 'a publication with new action', model_name
  it_behaves_like 'a publication with edit action', model_name
  it_behaves_like 'a publication with update action', model_name, valid_params, invalid_params, new_params
  it_behaves_like 'a publication with destroy action', model_name
end
