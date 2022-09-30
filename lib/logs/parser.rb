# frozen_string_literal: true

require 'ostruct'
require_relative 'record_contract'

module Logs
  # Parses log line extracting url_path and visitor IP
  class Parser
    def initialize(log_line:, validator: RecordContract.new)
      @log_line = log_line
      @validator = validator
    end

    def call
      path, ip = log_line.split
      raise InvalidLogFormatError unless path && ip

      parsed_log_record = { path:, ip: }

      validation = validator.call(parsed_log_record)
      raise InvalidLogRecord, validation.errors.to_h unless validation.success?

      OpenStruct.new(parsed_log_record)
    end

    private

    attr_reader :log_line, :validator

    # Error for log record in invalid format
    class InvalidLogFormatError < StandardError
      def initialize(message = 'Invalid log format')
        super
      end
    end

    # Error for log record with invalid path/IP
    class InvalidLogRecord < StandardError; end
  end
end
