# frozen_string_literal: true

# The PublicationsController is responsible for handling the requests for all
# publications.  Each model inherits its CRUD actions from this controller.
# We do not actually have a Publications model, so for testing purposes
# we will use the Book model, which is a child of the Publication model.
#
require 'rails_helper'

# We are calling BooksController, a "child" of PublicationsController, so we
# need to define it here.
RSpec.describe BooksController, type: :controller do
  it_behaves_like 'restricts non-logged-in users', {
    'index' => :get,
    'show' => :get,
    'new' => :get,
    'edit' => :get,
    'create' => :post,
    'update' => :put,
    'destroy' => :delete
  }
end
