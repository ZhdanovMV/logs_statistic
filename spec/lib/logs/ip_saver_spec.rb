# frozen_string_literal: true

require 'spec_helper'
require 'ostruct'
require_relative '../../../lib/logs/ip_saver'

RSpec.describe Logs::IpSaver do
  let(:ip_saver) { described_class.new }
  let(:log_record) { OpenStruct.new(path: '/about/2', ip: '444.701.448.104') }

  describe '#save' do
    subject(:save) { ip_saver.save(log_record) }

    let(:new_file_path) { 'tmp/ about 2' }

    after do
      File.delete(new_file_path)
    end

    it 'creates a new file with a name of the log path' do
      save
      expect(File.exist?(new_file_path)).to eq true
    end

    it 'adds a newly created file name to the list of tmp files' do
      save
      expect(ip_saver.page_files_with_list_of_ips).to include ' about 2'
    end

    it 'saves log ip the correct file' do
      save
      expect(File.read(new_file_path)).to eq "444.701.448.104\n"
    end
  end

  describe '#cleanup' do
    before do
      ip_saver.save(log_record)
    end

    it 'deletes created files' do
      ip_saver.cleanup
      expect(File.exist?('tmp/ about 2')).to eq false
    end
  end
end
