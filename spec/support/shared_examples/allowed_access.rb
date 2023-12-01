# frozen_string_literal: true

# Shared examples for verifying access control based on user roles.
# This example tests that a user with a specified role (e.g., admin, submitter) has appropriate access to different controller actions.
# - For 'create' actions, it expects a redirect to a dynamically determined URL based on the controller name.
# - For 'update' actions, it expects a redirect to the show page of the updated instance, dynamically determined from the controller.
# - For 'destroy' actions, it expects a redirect to the index page of the respective controller.
# - For 'new', 'edit', 'index', and 'show' actions, it expects a successful response.
# The user session is configured based on the provided user role, and the action is triggered using the appropriate HTTP method.
RSpec.shared_examples 'allowed access' do |action, method, user_role|
  it "allows #{user_role} users to access #{action}" do
    configure_user_session(user_role)
    public_send(method, action, params: params_for(action))

    case action
    when 'create'
      expect(response).to redirect_to(expected_url_after_create)
    when 'update'
      instance_var = instance_variable_get("@#{controller.controller_name.singularize}")
      expect(response).to redirect_to(instance_var)
    when 'destroy'
      expect(response).to redirect_to(publications_url)
    when 'new', 'edit', 'show'
      expect(response).to be_successful
    when 'index'
      if controller.controller_name == 'colleges'
        expect(response).to be_successful
      else
        expect(response).to redirect_to(publications_url)
      end
    end
  end
end

private

def expected_url_after_create
  controller.controller_name == 'colleges' ? College.last : publications_url
end

def index_url_for(controller_name)
  Rails.application.routes.url_helpers.url_for(controller: controller_name, action: :index, only_path: true)
end
