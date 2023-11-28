# frozen_string_literal: true

# Shared examples for 'restricted access' to test access control.
# This example verifies that users with the specified role (e.g., :admin, :submitter,
# or :none for non-logged-in users) are properly restricted from accessing certain
# controller actions, resulting in a 404 response.
#
# It configures the user session according to the given role and then makes a request to the specified action.
#
# Parameters:
# - action: The controller action being tested (e.g., :index, :show).
# - method: The HTTP method used for the request (e.g., :get, :post).
# - user_role: The user role being tested for restriction (default is :none for non-logged-in users).
RSpec.shared_examples 'restricted access' do |action, method, user_role = :none|
  it 'redirects to a 404 page' do
    configure_user_session(user_role)
    public_send(method, action, params: params_for(action))
    expect(response).to have_http_status(404)
  end
end
