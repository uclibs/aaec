# frozen_string_literal: true

require "#{Rails.root}/app/builders/autocomplete_off_form_builder"
Rails.application.config.action_view.default_form_builder = AutocompleteOffFormBuilder
