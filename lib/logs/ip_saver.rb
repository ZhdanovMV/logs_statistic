# frozen_string_literal: true

module Logs
  # Saves IP into the file with a name of visited page
  class IpSaver
    attr_reader :page_files_with_list_of_ips

    def initialize
      @page_files_with_list_of_ips = []
    end

    def save(log_record)
      filename = convert_path_to_filename(log_record.path)
      memorize_page_file(filename)
      File.write("tmp/#{filename}", "#{log_record.ip}\n", mode: 'a+')
    end

    def cleanup
      page_files_with_list_of_ips.map { |filename| File.delete("tmp/#{filename}") }
    end

    private

    def convert_path_to_filename(path)
      path.gsub(%r{/}, ' ')
    end

    def memorize_page_file(filename)
      page_files_with_list_of_ips << filename unless page_files_with_list_of_ips.include?(filename)
    end
  end
end
