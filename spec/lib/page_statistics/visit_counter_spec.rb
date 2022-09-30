# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/page_statistics/visit_counter'

RSpec.describe PageStatistics::VisitCounter do
  describe '#call' do
    subject(:call) { described_class.new([' about 2', ' index']).call }

    before do
      File.write('tmp/ about 2', "316.433.849.805\n", mode: 'a+')
      File.write('tmp/ index', "715.156.286.412\n646.865.545.408\n646.865.545.408\n", mode: 'a+')
    end

    after do
      File.delete('tmp/ about 2')
      File.delete('tmp/ index')
    end

    let(:expected_page_statistics) do
      {
        '/about/2' => {
          visits: 1,
          unique_views: 1,
          unique_ips: ['316.433.849.805']
        },
        '/index' => {
          visits: 3,
          unique_views: 2,
          unique_ips: ['715.156.286.412', '646.865.545.408']
        }
      }
    end

    it 'returns statistic for each page' do
      expect(call).to eq expected_page_statistics
    end
  end
end
