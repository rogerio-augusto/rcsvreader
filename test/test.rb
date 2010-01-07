require 'test/unit'
require '../lib/csv_reader.rb'

# Copyright (c) 2010, Daniel Quirino Oliveira
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#     * Neither the name of the owner nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

class TestCSVReader < Test::Unit::TestCase
  
  def setup
    @data_dir = "#{File.dirname(__FILE__)}/data/"
  end
  
  def test_fetch_all_rows_and_all_columns_sorted
    reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["name","email"])
    expected_lines = 4
    lines = 0
    reader.foreach do |line|
      lines += 1
    end
    assert_equal expected_lines, lines
  end
  
  def test_fetch_all_rows_and_all_columns_unsorted
    reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["email","name"])
    expected_lines = 4
    lines = 0
    reader.foreach do |line|
      lines += 1
    end
    assert_equal expected_lines, lines
  end
  
  def test_fetch_all_rows_and_only_expected_columns
    reader = CSV::CSVReader.new("#{@data_dir}/foo.csv", ["email"])
    expected_lines = 4
    lines = 0
    reader.foreach do |line|
      lines += 1
    end
    assert_equal expected_lines, lines
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