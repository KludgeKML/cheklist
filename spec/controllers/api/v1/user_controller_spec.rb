require 'rails_helper'

describe Api::V1::UserController, type: :controller do
  describe 'index' do
    it 'returns an empty list if no users' do
      get(:index)
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['users']).to eq([])
    end

    it 'returns a list of users' do
      User.create(display_name: 'tester')
      get(:index)
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['users']).to eq([{ 'display_name' => 'tester' }])
    end
  end
end
