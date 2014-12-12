describe FileParser::Parser do
  describe "create_objects_from_file" do
    context "parsing valid files (.csv & .txt)" do
      valid_menu_filepath_csv = "spec/test_data_files/simple_valid_menu.csv"
      valid_menu_filepath_txt = "spec/test_data_files/simple_valid_menu.txt"
      let(:csv_menu_data) {FileParser::Parser.create_objects_from_file(MenuItem, valid_menu_filepath_csv)}
      let(:txt_menu_data) {FileParser::Parser.create_objects_from_file(MenuItem, valid_menu_filepath_txt)}

      it "creates objects of class specified in arguments, based on data in file" do
        expect(csv_menu_data[:menu_items].first.class).to eq(MenuItem)
        expect(txt_menu_data[:menu_items].first.class).to eq(MenuItem)
      end

      it "creates the correct number of objects according to lines of data in file" do
        expect(csv_menu_data[:menu_items].length).to eq(3)
        expect(txt_menu_data[:menu_items].length).to eq(3)
      end

      it "correctly parses price total from file" do
        expect(csv_menu_data[:price_total]).to eq("$5.00")
        expect(txt_menu_data[:price_total]).to eq("$5.00")
      end

      it "correctly assigns instance variables to objects per file" do
        expect(csv_menu_data[:menu_items].last.name).to eq("beer")
        expect(csv_menu_data[:menu_items].last.price).to eq(300)

        expect(txt_menu_data[:menu_items].last.name).to eq("beer")
        expect(txt_menu_data[:menu_items].last.price).to eq(300)
      end

      it "does not return errors when file is valid" do
        expect(csv_menu_data[:error]).to be_nil
        expect(txt_menu_data[:error]).to be_nil
      end
    end

    context "parsing invalid files (.csv & .txt)" do
      invalid_menu_filepath_csv = "spec/test_data_files/simple_invalid_menu.csv"
      invalid_menu_filepath_txt = "spec/test_data_files/simple_invalid_menu.txt"
      let(:csv_menu_data) {FileParser::Parser.create_objects_from_file(MenuItem, invalid_menu_filepath_csv)}
      let(:txt_menu_data) {FileParser::Parser.create_objects_from_file(MenuItem, invalid_menu_filepath_txt)}

      it "correctly documents the line number with a missing comma" do
        expect(csv_menu_data[:error]).to match(/3/)
        expect(txt_menu_data[:error]).to match(/3/)
      end

      it "correctly does not document an error for line without dollar sign" do
        expect(csv_menu_data[:error]).to_not match(/2/)
        expect(txt_menu_data[:error]).to_not match(/2/)
      end

      it "correctly does not document an error for line without decimal places" do
        expect(csv_menu_data[:error]).to_not match(/4/)
        expect(txt_menu_data[:error]).to_not match(/4/)
      end

      it "correctly documents the line number for invalid char in target price" do
        expect(csv_menu_data[:error]).to match(/1/)
        expect(txt_menu_data[:error]).to match(/1/)
      end
    end
  end
end
