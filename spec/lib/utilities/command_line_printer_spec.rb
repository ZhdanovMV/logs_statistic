# frozen_string_literal: true

require_relative '../../../lib/utilities/command_line_printer'

RSpec.describe Utilities::CommandLinePrinter do
  describe '.print!' do
    subject(:print!) { described_class.print!(content) }

    let(:content) { "hello\nworld" }

    it 'prints content to stdout' do
      expect { print! }.to output("#{content}\n").to_stdout
    end
  end
end
