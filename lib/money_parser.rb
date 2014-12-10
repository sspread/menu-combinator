module MoneyParser

  class Dollar
    def self.convert_to_integer(amount)
      amount.to_s.gsub!("$", "").to_f*100.to_i
    end
  end

end