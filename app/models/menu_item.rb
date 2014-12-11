class MenuItem
  include MoneyParser
  attr_accessor :name, :price
  def initialize(args = {})
    @name = args[:name]
    @price = args[:price]
  end
  def convert_price_to_integer
    self.price = Dollar.convert_to_integer(self.price)
  end
end