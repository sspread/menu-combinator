  include MoneyParser
helpers do 

  def combo_count
    if @combos.length > 0
      "#{@combos.length} combinations"
    else
      "There are no possible combinations for that price."
    end
  end

  def monetize(amount)
    Dollar.convert_to_dollar(amount)
  end

end