module MoneyParser
  class Dollar
    def self.convert_to_integer(amount)
      (amount.to_s.gsub!("$", "").to_f*100).to_i
    end

    def self.convert_to_dollar(amount)
      amount = "$#{amount.to_f/100}"
      /\.\d{2}/ =~ amount ? amount : amount + "0" 
    end
  end
end