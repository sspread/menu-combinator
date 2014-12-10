class MenuItem
  include MoneyParser
  attr_accessor :name, :price
  def initialize(args = {})
    @name = args[:name]
    @price = args[:price]
  end
  def convert_price_to_integer
    p self
    self.price = Dollar.convert_to_integer(self.price)
  end
  def convert_to_dollar
    # self.price 
  end
end