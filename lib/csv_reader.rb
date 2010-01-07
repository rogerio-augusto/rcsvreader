require 'rubygems'
require 'ccsv'

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

module CSV
  
  class CSVReader
  
    def initialize(file, expected_header)
      @file = file
      check_header(expected_header)
      @expected_header = expected_header
    end
  
    # Iterates through the CSV file
    def foreach
      row_num = 0
      Ccsv.foreach(@file) do |r|
        yield parse_row(r) unless row_num == 0 #skips the header
        row_num += 1
      end
    end
  
    # Retrieves the column names from CSV header
    def header
      if @header == nil
        Ccsv.foreach(@file) do |line|
          @header = line
          break
        end
      end
      return @header
    end
  
    def check_header(expected_header)
      curr_header = header
      if (expected_header.empty?)
        raise InvalidHeaderException, "Expected header cannot be empty."
      end
      if (curr_header.size < expected_header.size ||
          (curr_header & expected_header).empty?)
          raise InvalidHeaderException, "Expected header #{expected_header} does not match or is not contained in the current header #{curr_header}."
      end
    end
  
    # Parses each row of the CSV file into a hash
    # Hash:
    # |Column1|Value1|
    # |Column2|Value2|
    #     .      .
    #     .      .
    # |ColumnN|ValueN|
    #
    # Column1-N represents a column as described in CSV header.
    # Values1-N represents a value for each row of the CSV file directly bound to the Nth column.
    def parse_row(r)
      row = {}
      i = 0
      @expected_header.each do |column|
        row[column] = r[header.index(column)]
        i += 1
      end
      return row
    end
  
    private :parse_row, :header, :check_header
      
  end

  class InvalidHeaderException < RuntimeError
    attr_reader :message
  
    def initialize(message)
      @message = message
    end
  end
end