require 'rails_helper'

describe Variable do  

  subject { Variable.new(name: 'test', value: 'test_val') }

  it 'has a name' do
  	expect(subject.name).to eq('test')
  end

  it 'has a value' do 
  	expect(subject.value).to eq('test_val')
  end
end
