# frozen_string_literal: true

module Utilities
  # Prints content to stdout
  class CommandLinePrinter
    def self.print!(content)
      print "#{content}\n"
    end
  end
end
