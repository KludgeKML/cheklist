require 'rails_helper'

describe Check do  
  before do
  	user = User.new(display_name: 'Fake')
  	repository = Repository.new(name: 'test/test', user: user)
  	@trigger = Trigger.new(description: 'fake trigger', repository: repository)
  end


  describe '#initialize' do
  	it 'allows a valid type' do
  		expect(Check.new(check_type: 'FileChanged', trigger: @trigger).valid?).to be true
  	end

  	it 'rejects an invalid type' do
  		expect(Check.new(check_type: 'FileExploded', trigger: @trigger).valid?).to be false
  	end
  end
end
