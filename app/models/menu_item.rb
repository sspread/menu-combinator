class MenuItem
  include MoneyParser
  attr_accessor :price
  attr_reader :name
  def initialize(args = {})
    @name = args[:name]
    @price = Dollar.convert_to_integer(args[:price])
  end
end