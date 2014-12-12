module FileParser
  require 'csv'
  
  class Parser
    def self.create_objects_from_file(object_class, filename)
      items = []
      error_lines = []
      menu_lines = CSV.read(filename)
      price_total = menu_lines.shift.first
      error_lines << 1 unless self.valid_price_total? price_total
      menu_lines.each.with_index do |line, index|
        if self.valid_line? line
          items << object_class.new(name: line.first, price: line.last)
        else
          error_lines << index+2
        end
      end
      error_msg = self.list_errors(error_lines) unless error_lines == []
      {price_total: price_total, menu_items: items, error: error_msg}
    end

    private
    def self.valid_line?(line)
      line.join(',') =~ /^[^\,]+\,\s*\$?\d+\.?\d{,2}$/
    end

    def self.list_errors(errors)
      "invalid line number(s): " + errors.join(', ')
    end

    def self.valid_price_total?(price_total)
      price_total =~ /^\$?\d*\.?\d{,2}$/
    end
  end
end