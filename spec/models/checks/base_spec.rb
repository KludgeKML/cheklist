require 'rails_helper'

describe Checks::Base do
  describe '#passed?' do
    it 'fails by default' do
      expect(Checks::Base.new(Check.new).passed?).to be false
    end
  end

  describe '#variables' do
    it 'lists the variables available' do
      expect(Checks::Base.new(Check.new).variable_names).to eq([])
    end
  end

  describe '#method_missing' do
    it 'behaves normally when variable missing' do
      expect{ Checks::Base.new(Check.new).my_missing_var }.to raise_error(NoMethodError)
    end
  end
end
