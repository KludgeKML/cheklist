require 'rails_helper'

describe Checks::FileChanged do
  before do
    user = User.new(display_name: 'Fake')
    repository = Repository.new(name: 'test/test', user: user)
    trigger = Trigger.new(description: 'fake trigger', repository: repository)
    @owner = Check.create(check_type: 'FileChanged', trigger: trigger)
    @file_changed = @owner.check_object
  end

  describe 'description' do
    it 'shows the static description' do
      expect(@file_changed.description).not_to be blank?
    end
  end

  describe 'description_complex' do
    it 'shows the complex description' do
      expect(@file_changed.description_complex).to include('README')
    end
  end


  describe '#variables' do
    it 'lists the variables available' do
      expect(@file_changed.variable_names).to eq([:filepath])
    end
  end

  describe '#filename' do
    it 'gives the default value' do
      expect(@file_changed.filepath).to eq('README')
    end

    context 'with a variable record' do
      before do
        @owner.variables.create!(name: 'filepath', value: 'DONOTREAD')
      end

      it 'gives the variable value' do
        expect(@file_changed.filepath).to eq('DONOTREAD')
      end
    end
  end
end
