describe MenuItem do
  let(:menu_item) {MenuItem.new({name: "beans", price: "$2.50"})}
  describe "initialize" do
    it "should create a name attribute" do
      menu_item.should respond_to(:name)
    end
    it "should create a price attribute" do
      menu_item.should respond_to(:price)
    end
    it "should convert price to an penny integer on create" do
      expect(menu_item.price).to eq(250)
    end
  end
end
