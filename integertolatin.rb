module IntegerToLatin
  def integer_to_latin(number)
    @converter ||= Converter.new
    @converter.verify(number)
    @converter.convert(number)
  end
end

class Converter
  UNITS = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
  TENS = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
  HUNDREDS = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCC", "DM"]
  THOUSANDS = ["", "M", "MM", "MMM", "MMMM"]

  def convert(number)
    number = number.reverse.split(//)
    roman_number = Array.new

    number.each_with_index do |this_number, i|
      this_number = (this_number.to_i)
      case i
      when 0
        roman_number[3] = UNITS[this_number]
      when 1
        roman_number[2] = TENS[this_number]
      when 2
        roman_number[1] = HUNDREDS[this_number]
      when 3
        roman_number[0] = THOUSANDS[this_number]
      end
    end

    return roman_number.join
  end

  def verify(number)
    if number.to_i >= 5000
      raise "numbers shouldn't be over 4999"
    elsif number.split.any? { |val| /^\D/ =~ val } || number.split.empty?
      raise "only digit characters are allowed"
    end
  end
end
