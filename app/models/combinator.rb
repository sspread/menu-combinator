class Combinator
  include MoneyParser
  
  attr_accessor :menu_items, :total, :combos
  def initialize(data)
    @menu_items = money_to_integer!(data[:menu_items])
    @total = Dollar.convert_to_integer(data[:price_total])
    @combos = []
  end

  def solve(total = @total, combo = {})
    if total == 0
      @combos << combo unless @combos.include? combo
      return
    end

    @menu_items.each do |item|
      range = (1..(total/item.price))
      range.each do |quantity|
        unless combo[item]
          combo_copy = combo.clone
          combo_copy[item] = quantity
          new_total = total-(item.price*quantity)
          solve(new_total, combo_copy)
        else
          return
        end
      end
    end
  end
  
  private
  def money_to_integer!(arr)
    arr.each {|obj| obj.convert_price_to_integer }
  end
end