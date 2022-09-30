# frozen_string_literal: true

module Utilities
  # Reads file content in lazy mode
  class FileReader
    def initialize(file_path)
      @file_path = file_path
      validate_file_presence!
      validate_file_extension!
    end

    def each_line(&block)
      File.foreach(file_path, &block)
    end

    private

    attr_reader :file_path

    def validate_file_presence!
      raise InvalidFilePathError unless File.exist?(file_path)
    end

    def validate_file_extension!
      raise InvalidFileExtensionError if File.extname(file_path) != '.log'
    end

    # Error for nonexistent files
    class InvalidFilePathError < StandardError
      def initialize(message = 'Invalid file path')
        super
      end
    end

    # Error for files with incorrect extensions
    class InvalidFileExtensionError < StandardError
      def initialize(message = 'Invalid file extension')
        super
      end
    end
  end
end
