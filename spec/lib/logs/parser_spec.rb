# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'
require_relative '../../../lib/logs/parser'

RSpec.describe Logs::Parser do
  describe '#call' do
    subject(:call) { described_class.new(log_line:, validator: fake_validator).call }

    let(:log_line) { '/about/2 126.318.035.038' }

    let(:fake_validator) { instance_double(Logs::RecordContract, call: validation_result) }
    let(:validation_result) { instance_double(Dry::Validation::Result, success?: true) }

    it 'returns a log record' do
      expect(call).to eq OpenStruct.new(path: '/about/2', ip: '126.318.035.038')
    end

    context 'when log is in invalid format' do
      let(:log_line) { '/about/2,126.318.035.038' }

      it 'raises InvalidLogFormatError' do
        expect { call }.to raise_error Logs::Parser::InvalidLogFormatError
      end
    end

    context 'when log validation fails' do
      let(:validation_result) do
        instance_double(Dry::Validation::Result, success?: false, errors: { ip: 'Must be IP address' })
      end

      it 'raises InvalidLogRecord' do
        expect { call }.to raise_error Logs::Parser::InvalidLogRecord
      end
    end
  end
end
