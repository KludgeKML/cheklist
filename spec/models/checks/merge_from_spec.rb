require 'rails_helper'

describe Checks::MergeFrom do
  before do
    user = User.new(display_name: 'Fake')
    repository = Repository.new(name: 'test/test', user: user)
    trigger = Trigger.new(description: 'fake trigger', repository: repository)
    @owner = Check.create(check_type: 'MergeFrom', trigger: trigger)
    @file_changed = @owner.check_object
  end

  describe 'description' do
    it 'shows the static description' do
      expect(@file_changed.description).not_to be blank?
    end
  end

  describe 'description_complex' do
    it 'shows the complex description' do
      expect(@file_changed.description_complex).to include('master')
    end
  end

  describe '#variables' do
    it 'lists the variables available' do
      expect(@file_changed.variable_names).to eq([:branch])
    end
  end

  describe '#branch' do
    it 'gives the default value' do
      expect(@file_changed.branch).to eq('master')
    end

    context 'with a variable record' do
      before do
        @owner.variables.create!(name: 'branch', value: 'staging')
      end

      it 'gives the variable value' do
        expect(@file_changed.branch).to eq('staging')
      end
    end
  end
end
