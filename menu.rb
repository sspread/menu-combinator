class Combo
  attr_accessor :combo
  def initialize(name = "Food")
    @combo = {name: name, price: 0, quantity: 0}
  end
  def add_item(price, quantity) 
  end
  private
  def combo_total
    sum = []
    @combo.each do |key, value|
      sum << key*value
    end
    sum.inject(:+)
  end
end

class Combinator
  attr_accessor :menu_prices, :total, :combos, :count
  def initialize(menu_prices, total)
    @menu_prices = integerize(menu_prices)
    @total = total*100
    @combos = []
  end

  def integerize(arr)
    arr.map {|n| n*100}
  end

  def monetize_combo(hash)
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
    @count+=1
    if total == 0
      puts "Pushing combo: #{combo} -- #{@count}"
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



combinator = Combinator.new([3.5,3.5,2,1], 3.5)
combinator.solve
puts combinator.combos
p combinator.combos.count
p combinator.combos.uniq.count
puts combinator.count
combinator.combos.each {|combo| puts Combinator.combo_total(combo)}


