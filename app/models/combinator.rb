class Combinator
  include MoneyParser
  
  attr_accessor :menu_items, :total, :combos
  def initialize(data)
    @menu_items = money_to_integer!(data[:menu_items])
    @total = Dollar.convert_to_integer(data[:price_total])
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

  def min_attribute_value_in_arr_of_objects(arr)
    min = 0
    arr.each do |obj|
      price = yield obj
      min = price if price < min
    end
    min
  end

  def solve(total = @total, menu_items = @menu_items, combo = {})
    if total == 0
      puts "Pushing combo: #{combo}"
      @combos << combo unless @combos.include? combo
      return
    end

    menu_items = menu_items.select {|item| item.price <= total} 
    menu_items.each do |item|
      puts "First Loop"
      range = (1..(total/item.price))
      range.each do |quantity|
        puts "Second Loop"
        unless combo[item]
          combo_copy = combo.dup
          combo_copy[item] = quantity
          new_total = total-(item.price*quantity)
          solve(new_total, menu_items, combo_copy)
        else
          return
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



#     def solve(total = @total, menu_items = @menu_items, combo = {})
#     if total == 0
#       puts "Pushing combo: #{combo}"
#       @combos << combo
#       return
#     end

#     return if menu_items == [] || total.to_i < max_attribute_value_in_arr_of_objects(menu_items) {|obj| obj.price}
#   menu_items = menu_items.select {|item| item.price <= total} 
#     menu_items.each do |item|
#       range = (1..(total/item.price))
#       range.each do |quantity|
#         unless combo[item]
#           combo_copy = combo.dup
#           combo_copy[item] = quantity
#           new_total = total-(item.price*quantity)
#           # binding.pry
#           solve(new_total, menu_items, combo_copy)
#         end
#       end
#     end
#   end
# end