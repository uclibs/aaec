# frozen_string_literal: true

def login_as_submitter_of(resource)
  raise ArgumentError, 'Resource must not be nil' unless resource

  submitter_id = extract_submitter_id_from(resource)
  log_in_submitter(submitter_id)
end

def login_as_admin
  session[:admin] = true
end

def user_is_admin?
  session[:admin]
end

def logged_in_submitter_id
  session[:submitter_id].to_s
end

private

def extract_submitter_id_from(resource)
  if resource.is_a?(Submitter)
    resource.id
  elsif resource.respond_to?(:submitter)
    resource.submitter.id
  elsif resource.respond_to?(:submitter_id)
    resource.submitter_id
  else
    raise ArgumentError, 'Resource does not have an associated submitter or submitter_id'
  end
end

def log_in_submitter(submitter_id)
  session[:submitter_id] = submitter_id
end
