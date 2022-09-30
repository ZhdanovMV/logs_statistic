# frozen_string_literal: true

module PageStatistics
  # Counts visits and unique views for each file with IPs
  class VisitCounter
    def initialize(file_names, files_directory: 'tmp')
      @file_names = file_names
      @files_directory = files_directory
      @statistics = {}
      file_names.each do |file_name|
        statistics[file_name] = {
          visits: 0,
          unique_views: 0,
          unique_ips: []
        }
      end
    end

    def call
      file_names.each do |file_name|
        File.foreach("#{files_directory}/#{file_name}") do |ip|
          page_statistic = statistics[file_name]

          page_statistic[:visits] += 1

          unless page_statistic[:unique_ips].include?(ip.strip)
            page_statistic[:unique_ips] << ip.strip
            page_statistic[:unique_views] += 1
          end
        end
      end

      statistics.transform_keys { |key| convert_filename_to_page_path(key) }
    end

    private

    attr_reader :statistics, :file_names, :files_directory

    def convert_filename_to_page_path(filename)
      filename.gsub(/ /, '/')
    end
  end
end
