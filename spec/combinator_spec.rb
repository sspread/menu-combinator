include FileParser
describe Combinator do
  before(:each) do
    @beans = MenuItem.new({name: "beans", price: "$1.00"})
    @milk = MenuItem.new({name: "milk", price: "$2.00"})
    @cheese = MenuItem.new({name: "cheese", price: "$3.00"})
    price_total = "$5.00"
    menu_items = [@beans, @milk, @cheese]
    @combinator = Combinator.new({price_total: price_total, menu_items: menu_items})
  end

  def combination_average(combos)
    sum = []
    combos.each do |combo|
      combo.each do |item, qty|
        sum << item.price*qty
      end
    end
    (sum.inject(:+)/combos.length).to_f
  end
  
  describe "initialize" do 
    it "should create an instance of menu_items array" do
      menu_items = @combinator.instance_variable_get(:@menu_items)
      expect(menu_items.length).to eq(3)
    end
    it "should create an instance of total price, converted to integer cents" do
      total = @combinator.instance_variable_get(:@total)
      expect(total).to eq(500)
    end
    it "should create an empty combos array" do
      expect(@combinator.combos).to be_empty
    end
  end

  describe "solve" do
    it "should create an array of every unique menu combination, including multiple of same item (result of simple test known with certainty)" do
      @combinator.solve
      expected_solution = [ {@beans => 5},
                            {@milk => 1, @beans => 3},
                            {@milk => 2, @beans => 1},
                            {@cheese => 1, @beans => 2},
                            {@milk => 1, @cheese => 1} ]
      expect(@combinator.combos).to eq(expected_solution)
    end
    it "should handle a complex combination challenge (test by checking that each combo is unique and sums to target price)" do
      filepath = 'spec/test_data_files/challenging_menu.txt'
      menu_data = Parser.create_objects_from_file(MenuItem, filepath)
      combinator = Combinator.new(menu_data)
      combinator.solve
      expect(combinator.combos).to eq(combinator.combos.uniq)
      expect(combination_average(combinator.combos)).to eq(combinator.instance_variable_get(:@total))
    end

    it "should not return any combinations if none are possible" do
      @combinator.instance_variable_set(:@total, 501)
      @combinator.solve
      expect(@combinator.combos).to be_empty
    end
  end
end
