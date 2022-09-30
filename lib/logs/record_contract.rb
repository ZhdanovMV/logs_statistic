# frozen_string_literal: true

require 'dry/validation'

module Logs
  # Log validation
  class RecordContract < Dry::Validation::Contract
    URL_PATH_FORMAT = %r{^/[a-z_/\d]*$}
    WEIRD_IP_FORMAT = /(\d{3}\.?){4}/

    params do
      required(:path).filled { str? && format?(URL_PATH_FORMAT) }
      required(:ip).filled { str? && format?(WEIRD_IP_FORMAT) }
    end
  end
end
