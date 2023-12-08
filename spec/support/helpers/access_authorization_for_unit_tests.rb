# frozen_string_literal: true

# Configures the user session based on the specified role.
# This helper method sets the session state to mimic different user roles (:admin, :submitter, or :none).
# For an admin user, it sets session[:admin] to true and removes any submitter_id.
# For a submitter user, it sets session[:submitter_id] to a submitter's ID and ensures session[:admin] is false.
# For a non-logged-in user (:none), it clears both admin and submitter_id from the session.
# This method is used in testing to simulate different user access scenarios in controller actions.
# Parameters:
# - user_role: Symbol representing the user role (:admin, :submitter, or :none).
def configure_user_session(user_role, resource = nil)
  case user_role
  when :admin
    session[:admin] = true
    session.delete(:submitter_id)
  when :submitter_owner, :submitter_non_owner
    session.delete(:admin)
    # For :submitter_owner, pass the actual resource.
    # For :submitter_non_owner, create a new submitter to simulate a non-owner.
    login_as_submitter_of(user_role == :submitter_owner ? resource : FactoryBot.create(:submitter))
  when :none
    session.delete(:admin)
    session.delete(:submitter_id)
  end
end

# Generates parameters for controller action tests based on the specified action.
# This helper method provides a convenient way to create the necessary parameters for various controller actions.
# It returns a hash containing the record's ID for actions that typically require an identifier
# (show, edit, update, destroy).
# For other actions that do not require specific parameters (like index or new), it returns an empty hash.
# This method simplifies test setup by dynamically generating appropriate parameters for each action.
# Parameters:
# - action: The controller action for which parameters are needed (e.g., 'show', 'edit').
# - record: The record object used to extract the ID for parameter generation.
def params_for(action, resource = nil)
  case action
  when 'create'
    create_params
  when 'update'
    update_params(resource)
  when 'edit', 'destroy', 'show'
    id_params(resource)
  else
    {}
  end
end

private

def create_params
  model_name_underscore = model_name_underscored
  { model_name_underscore => FactoryBot.attributes_for(model_name_underscore.to_sym) }
end

def update_params(resource = nil)
  model_name_underscore = model_name_underscored
  record = resource || FactoryBot.create(model_name_underscore.to_sym)
  updated_attributes = FactoryBot.attributes_for(model_name_underscore.to_sym)
  { id: record.id, model_name_underscore => updated_attributes }
end

def id_params(resource = nil)
  model_name_underscore = model_name_underscored
  record = resource || FactoryBot.create(model_name_underscore.to_sym)
  { id: record.id }
end

def model_name_underscored
  model = controller.controller_name.classify.constantize
  model.to_s.underscore
end
