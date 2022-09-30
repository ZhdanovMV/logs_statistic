#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'lib/utilities/file_reader'
require_relative 'lib/logs/parser'
require_relative 'lib/logs/ip_saver'
require_relative 'lib/page_statistics/visit_counter'
require_relative 'lib/page_statistics/sorter'
require_relative 'lib/page_statistics/formatter'
require_relative 'lib/utilities/command_line_printer'

# Reads logs from file and prints statistic to stdout
class LogsStatistic
  def initialize(log_file_path:)
    @log_file_path = log_file_path
  end

  def call
    Utilities::FileReader.new(log_file_path).each_line do |log_line|
      parsed_log = Logs::Parser.new(log_line:).call
      ip_saver.save(parsed_log)
    end

    page_statistics = PageStatistics::VisitCounter.new(ip_saver.page_files_with_list_of_ips).call

    print_statistics_sorted_by(page_statistics:, parameter: :visits)
    print_statistics_sorted_by(page_statistics:, parameter: :unique_views)
  rescue StandardError => e
    p e.message
  ensure
    ip_saver.cleanup
  end

  private

  attr_reader :log_file_path

  def print_statistics_sorted_by(page_statistics:, parameter:)
    sorted_statistics = PageStatistics::Sorter.new(page_statistics).sort_by(parameter)
    formatted_statistics = PageStatistics::Formatter.new(sorted_statistics).format_for(parameter)
    Utilities::CommandLinePrinter.print!(formatted_statistics)
  end

  def ip_saver
    @ip_saver ||= Logs::IpSaver.new
  end
end

LogsStatistic.new(log_file_path: ARGV[0]).call
