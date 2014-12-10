class Combinator
  include MoneyParser
  attr_accessor :menu_prices, :total, :combos
  def initialize(data)
    @menu_items = money_to_integer!(data[:menu_items])
    # @menu_prices = money_to_integer(menu_prices)
    @total = data[:price_total]*100
    @combos = []
  end

  def money_to_integer!(arr)
    arr.each {|obj| obj.convert_price_to_integer }
  end

  def integer_to_money(hash)
    hash.values.map {|n| n.to_f/100}
  end
  def self.combo_total(hash)
    sum = []
    hash.each do |key, value|
      sum << key*value
    end
    sum.inject(:+)
  end
  def solve(total = @total, menu_prices = @menu_prices, combo = {})
    if total == 0
      puts "Pushing combo: #{combo}"
      @combos << combo
      return
    end

    return if menu_prices == [] || total < menu_prices.max

    menu_prices.each do |item_price|
      range = (1..(total/item_price))
      range.each do |quantity|
        unless combo[item_price]
          combo_copy = combo.dup
          combo_copy[item_price] = quantity
          new_total = total-(item_price*quantity)
          menu_prices = menu_prices.select {|item| item <= new_total} 
          solve(new_total, menu_prices, combo_copy)
        end
      end
    end
  end
end


  # def solve(total = @total, menu_prices = @menu_prices, combo = {})
  #   if total == 0
  #     puts "Pushing combo: #{combo}"
  #     @combos << combo
  #     return
  #   end

  #   return if menu_prices == [] || total < menu_prices.max

  #   menu_prices.each do |item_price|
  #     range = (1..(total/item_price))
  #     range.each do |quantity|
  #       unless combo[item_price]
  #         combo_copy = combo.dup
  #         combo_copy[item_price] = quantity
  #         new_total = total-(item_price*quantity)
  #         menu_prices = menu_prices.select {|item| item <= new_total} 
  #         solve(new_total, menu_prices, combo_copy)
  #       end
  #     end
  #   end
  # end
