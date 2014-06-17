require 'spec_helper'
require 'integertolatin'

class Test
  include IntegerToLatin
end

describe IntegerToLatin do
  subject { Test.new }

  describe '#converter' do
    describe 'should replace numbers by the right letters' do
      it 'units should be convert correctly' do
        result = subject.integer_to_latin("7")
        expect(result).to eq("VII")
      end

      it 'tens should be convert correctly' do
        result = subject.integer_to_latin("40")
        expect(result).to eq("XL")
      end

      it 'hundreds should be convert correctly' do
        result = subject.integer_to_latin("700")
        expect(result).to eq("DCC")
      end

      it 'thousands should be convert correctly' do
        result = subject.integer_to_latin("4000")
        expect(result).to eq("MMMM")
      end

      it 'a full number should be convert correctly' do
        result = subject.integer_to_latin("4678")
        expect(result).to eq("MMMMDCLXXVIII")
      end
    end

    it 'should puts letters in the right order' do
      result = subject.integer_to_latin("2222")
      result = result.scan(/[A-Z]{2}/m)
      expect(result[0]).to eq("MM")
      expect(result[1]).to eq("CC")
      expect(result[2]).to eq("XX")
      expect(result[3]).to eq("II")
    end
  end

  describe '#verify' do
    it 'should raise an error if the number is over 4999' do
      expect{subject.integer_to_latin("5000")}.to raise_error("numbers shouldn't be over 4999")
    end

    it 'should raise an error if there is others characters than numbers' do
      expect{subject.integer_to_latin("B")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_latin("/")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_latin(".")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_latin("")}.to raise_error("only digit characters are allowed")
    end
  end
end
