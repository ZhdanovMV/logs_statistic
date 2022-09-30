# frozen_string_literal: true

module PageStatistics
  # Sorts page statistics by visits or unique views
  class Sorter
    def initialize(page_statistics)
      @page_statistics = page_statistics
    end

    SORT_OPTIONS = %i[visits unique_views].freeze

    def sort_by(key)
      raise ArgumentError unless SORT_OPTIONS.include?(key)

      page_statistics.sort_by { |_page, statistic| statistic[key] }.reverse.to_h
    end

    private

    attr_reader :page_statistics
  end
end
