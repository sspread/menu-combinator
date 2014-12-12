class Combinator
  include MoneyParser
  attr_reader :combos
  def initialize(data)
    @menu_items = data[:menu_items]
    @total = Dollar.convert_to_integer(data[:price_total])
    @combos = []
  end

  def solve(total = @total, combo = {})
    return @combos << combo if total == 0 && !(@combos.include? combo)
    @menu_items.each do |item|
      qty_range = (1..(total/item.price))
      qty_range.each do |quantity|
        return if combo[item]
        combo_copy = combo.dup
        combo_copy[item] = quantity
        new_total = total-(item.price*quantity)
        solve(new_total, combo_copy)
      end
    end
  end
end