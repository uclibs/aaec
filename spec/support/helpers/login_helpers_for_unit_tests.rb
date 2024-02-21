# frozen_string_literal: true

def login_as_submitter_of(resource)
  raise ArgumentError, 'Resource must not be nil' unless resource

  submitter_id = extract_submitter_id_from(resource)
  log_in_submitter(submitter_id)
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
  session.delete(:admin)
end

def login_as_admin_unit_test
  session[:admin] = true
  session.delete(:submitter_id)
end
