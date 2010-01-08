require 'test/unit'
require '../lib/csv_reader.rb'

class TestContactsCsvValidator < Test::Unit::TestCase
  
  def setup
    @data_dir = "#{File.dirname(__FILE__)}/data/"
    @valid_header = ["name", "email"]
  end

  def loader_should_ignore_blank_lines
   reader = CSVReader.new("#{@data_dir}/foo.csv", "name,email")
   file_content = reader.load_file_contents_as_array
   
   assert_equal @valid_header, file_content[0]
  end
  
  def test_accept_partial_valid_header
    assert_nothing_raised do
      reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["name"]) 
    end
  end
  
  def test_fail_missing_age_column_in_csv_header
    assert_raise CSV::InvalidHeaderException do
      reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["name", "email", "age"]) 
    end
  end
  
  def test_fail_invalid_header
    assert_raise CSV::InvalidHeaderException do
      reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["foo","bar"]) 
    end     
  end
  
  def test_fail_no_expected_header
    assert_raise CSV::InvalidHeaderException do
      reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", []) 
    end     
  end
  
  
  
end