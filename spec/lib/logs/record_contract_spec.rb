# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'
require_relative '../../../lib/logs/record_contract'

RSpec.describe Logs::RecordContract do
  describe '#call' do
    subject(:call) { described_class.new.call(log_record) }

    let(:log_record) { { path: '/about/2', ip: '444.701.448.104' } }

    specify 'validation is successful' do
      expect(call).to be_success
    end

    context 'when path is missing' do
      let(:log_record) { { path: nil, ip: '444.701.448.104' } }

      specify 'validation fails' do
        expect(call).not_to be_success
      end
    end

    context 'when path is in invalid format' do
      let(:log_record) { { path: '/about.me/2', ip: '444.701.448.104' } }

      specify 'validation fails' do
        expect(call).not_to be_success
      end
    end

    context 'when ip is missing' do
      let(:log_record) { { path: '/about/2', ip: nil } }

      specify 'validation fails' do
        expect(call).not_to be_success
      end
    end

    context 'when ip is in invalid format' do
      let(:log_record) { { path: '/about/2', ip: '444.701.448.abc' } }

      specify 'validation fails' do
        expect(call).not_to be_success
      end
    end
  end
end
