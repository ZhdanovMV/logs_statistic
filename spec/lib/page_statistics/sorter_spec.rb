# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/page_statistics/sorter'

RSpec.describe PageStatistics::Sorter do
  describe '#sort_by' do
    let(:sorter) { described_class.new(page_statistics) }

    let(:page_statistics) do
      {
        '/about/2' => {
          visits: 3,
          unique_views: 1,
          unique_ips: ['316.433.849.805']
        },
        '/index' => {
          visits: 2,
          unique_views: 2,
          unique_ips: ['715.156.286.412', '646.865.545.408']
        }
      }
    end

    describe 'visits' do
      subject(:sort_by_visits) { sorter.sort_by(:visits) }

      let(:sorted_by_visits) do
        {
          '/about/2' => {
            visits: 3,
            unique_views: 1,
            unique_ips: ['316.433.849.805']
          },
          '/index' => {
            visits: 2,
            unique_views: 2,
            unique_ips: ['715.156.286.412', '646.865.545.408']
          }
        }
      end

      it 'sorts by visits' do
        expect(sort_by_visits).to eq sorted_by_visits
      end
    end

    describe 'unique_views' do
      subject(:sort_by_unique_views) { sorter.sort_by(:unique_views) }

      let(:sorted_by_unique_views) do
        {
          '/index' => {
            visits: 2,
            unique_views: 2,
            unique_ips: ['715.156.286.412', '646.865.545.408']
          },
          '/about/2' => {
            visits: 3,
            unique_views: 1,
            unique_ips: ['316.433.849.805']
          }
        }
      end

      it 'sorts by unique_views' do
        expect(sort_by_unique_views).to eq sorted_by_unique_views
      end
    end
  end
end
