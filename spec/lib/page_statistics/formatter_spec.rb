# frozen_string_literal: true

require_relative '../../../lib/page_statistics/formatter'

RSpec.describe PageStatistics::Formatter do
  let(:formatter) { described_class.new(page_statistics) }

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

  describe '#format_for' do
    describe 'visits' do
      subject(:format_for_visits) { formatter.format_for(:visits) }

      it 'formats page statistics for visits' do
        expect(format_for_visits).to eq "/about/2 3 visits\n/index 2 visits"
      end
    end

    describe 'unique views' do
      subject(:format_for_unique_views) { formatter.format_for(:unique_views) }

      it 'formats page statistics for unique views' do
        expect(format_for_unique_views).to eq "/about/2 1 unique views\n/index 2 unique views"
      end
    end
  end
end
