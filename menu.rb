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





# combinator = Combinator.new([3.5,3.5,2,1], 3.5)
# combinator.solve
# puts combinator.combos
# p combinator.combos.count
# p combinator.combos.uniq.count
# puts combinator.count
# combinator.combos.each {|combo| puts Combinator.combo_total(combo)}


