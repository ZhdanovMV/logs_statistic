# frozen_string_literal: true

module PageStatistics
  # Formats page statistics using passed text
  class Formatter
    def initialize(page_statistics)
      @page_statistics = page_statistics
    end

    def format_for(key)
      page_statistics.map do |page, statistic|
        "#{page} #{statistic[key]} #{format_key(key)}"
      end.join("\n")
    end

    private

    attr_reader :page_statistics

    def format_key(key)
      key.to_s.gsub(/_/, ' ')
    end
  end
end
