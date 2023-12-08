# frozen_string_literal: true

# Shared examples for testing that only admin users and the submitter of the item have access to certain actions.
# Non-owner submitters are expected to receive a 404 response.
# The example dynamically determines the model based on the controller and creates a record for it.
# It then iterates over a provided hash of actions and methods, setting up tests for each.
# For each action, it tests three contexts:
# 1. Non-admin and non-owner submitters are restricted (expecting a 404 response).
# 2. Owner submitters are allowed access (expecting a successful response or redirect as appropriate).
# 3. Admin users are allowed access (expecting a successful response or redirect as appropriate).
# This ensures that actions are securely accessible only by intended user roles.
# Parameters:
# - actions: A hash where keys are action names and values are the corresponding HTTP methods.
RSpec.shared_examples 'admin_and_owner_access_only' do |actions|
  actions.each do |action, method|
    describe "#{method.upcase} ##{action}" do
      context 'when non-admin and non-owner submitter' do
        include_examples 'restrict to 404', action, method, :other_submitter
      end

      context 'when owner submitter' do
        include_examples 'allowed access', action, method, :owner
      end

      context 'when admin user' do
        include_examples 'allowed access', action, method, :admin
      end
    end
  end
end
