# frozen_string_literal: true

require_relative '../../../lib/utilities/file_reader'

RSpec.describe Utilities::FileReader do
  let(:file_path) { 'tmp/test_file.log' }

  before do
    File.write(file_path, "hello\nworld\n", mode: 'a+')
  end

  after do
    File.delete(file_path)
  end

  describe '.new' do
    subject(:new) { described_class.new(file_path) }

    it 'does not raise error' do
      expect { new }.not_to raise_error
    end

    context 'when file_path if invalid' do
      subject(:new) { described_class.new('invalid.log') }

      it 'raises InvalidFilePathError' do
        expect { new }.to raise_error Utilities::FileReader::InvalidFilePathError
      end
    end

    context 'when file has incorrect extension' do
      let(:file_path) { 'tmp/test_file.jpeg' }

      it 'raises InvalidFileExtensionError' do
        expect { new }.to raise_error Utilities::FileReader::InvalidFileExtensionError
      end
    end
  end

  describe '#each_line' do
    let(:file_reader) { described_class.new(file_path) }

    specify { expect { |b| file_reader.each_line(&b) }.to yield_control.twice }
  end
end
