require 'rubygems'

class CSVReader
  attr_accessor :file
  
  def initialize(file, expected_header)
    @file = file
    
    raise ArgumentError, "Expected header cannot be empty." if expected_header.empty?
    @expected_header = expected_header
  end
  
  def valid_file_header?
    raise ArgumentError, "File does not exists: #{@file}" unless File.exists? file
  
    first_two_lines = load_file_contents_as_array 2
  
    raise "File must have header and content" if first_two_lines.size < 2

    file_header = first_two_lines[0].split(%r{,\s*})
    required_header = @expected_header.split(%r{,\s*})
    
    file_header == required_header
  end
  
  def load_file_contents_as_array(row_limit = 0)
    grep = "grep -v '^$' #{@file}"
    head_block = "| head -n #{row_limit} "

    `#{grep} #{head_block unless row_limit == 0}`.split(/[\n]+/)
  end
end