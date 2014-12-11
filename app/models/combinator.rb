class Combinator
  include MoneyParser
  
  attr_accessor :menu_items, :total, :combos
  def initialize(data)
    @menu_items = money_to_integer!(data[:menu_items])
    @total = Dollar.convert_to_integer(data[:price_total])
    @combos = []
  end

  def solve(total = @total, combo = {})
    return @combos << combo if total == 0 && !(@combos.include? combo)
    @menu_items.each do |item|
      range = (1..(total/item.price))
      range.each do |quantity|
        return if combo[item]
        combo_copy = combo.clone
        combo_copy[item] = quantity
        new_total = total-(item.price*quantity)
        solve(new_total, combo_copy)
      end
    end
  end
  
  private
  def money_to_integer!(arr)
    arr.each {|obj| obj.convert_price_to_integer }
  end
end