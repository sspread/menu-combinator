module FileParser
  require 'csv'
  
  class CSVParser
  
    def self.create_objects_from_file(object_class, filename)
      menu_lines = CSV.read(filename)
      price_total = menu_lines.shift.first
      items = []
      menu_lines.each do |line|
        items << object_class.new(name: line.first, price: line.last)
      end
      return {price_total: price_total, menu_items: items}
    end
  end

  class TextParser
  end

end