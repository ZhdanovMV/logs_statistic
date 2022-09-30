# frozen_string_literal: true

require 'spec_helper'
require_relative '../logs_statistic'

RSpec.describe LogsStatistic do
  let(:log_file_path) { 'spec/shared/test_webserver.log' }

  describe '#call' do
    subject(:call) { described_class.new(log_file_path:).call }

    let(:expected_result) do
      [ # rubocop:disable Style/StringConcatenation
        '/about/2 90 visits',
        '/contact 89 visits',
        '/index 82 visits',
        '/about 81 visits',
        '/help_page/1 80 visits',
        '/home 78 visits',
        '/index 23 unique views',
        '/home 23 unique views',
        '/contact 23 unique views',
        '/help_page/1 23 unique views',
        '/about/2 22 unique views',
        '/about 21 unique views'
      ].join("\n") + "\n"
    end

    it 'prints content to stdout' do
      expect { call }.to output(expected_result).to_stdout
    end
  end
end
