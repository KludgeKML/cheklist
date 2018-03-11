require 'rails_helper'

describe Variable do  

  subject { Variable.new('test', 'test_val') }

  it 'has a name' { expect(subject.name).to eq ('test') }

  it 'has a value' { expect(subject.value).to eq ('test_val') }
end
