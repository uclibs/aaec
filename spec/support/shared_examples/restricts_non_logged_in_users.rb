# frozen_string_literal: true

# Shared examples for testing that only logged in users have access to certain actions.
# This example dynamically determines the model based on the controller and creates a record for it.
# It then iterates over a provided hash of actions and methods, setting up tests for each.
# For each action, it tests three contexts:
# 1. Non-admin and non-submitter users are restricted (expecting a 404 response).
# 2. Submitter users are allowed access (expecting a successful response or redirect as appropriate).
# 3. Admin users are allowed access (expecting a successful response or redirect as appropriate).
# This ensures that only logged in users can access these specific actions in the controller.
# Parameters:
# - actions: A hash where keys are action names and values are the corresponding HTTP methods.
RSpec.shared_examples 'restricts non-logged-in users' do |actions|
  actions.each do |action, method|
    describe "#{method.upcase} ##{action}" do
      context 'when non-admin and non-submitter user' do
        include_examples 'redirect to root', action, method, :none
      end

      context 'when submitter user' do
        include_examples 'allowed access', action, method, :submitter_non_owner
      end

      context 'when admin user' do
        include_examples 'allowed access', action, method, :admin
      end
    end
  end
end
