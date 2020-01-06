# frozen_string_literal: true

json.array! @submitters, partial: 'submitters/submitter', as: :submitter
