require 'rails_helper'

describe Api::V1::GithubController, type: :controller do  
  describe 'hook' do
    it 'registers an anonymous pulse' do
      post('api/v1/github/hook', params: { data: {}.to_json, id: 'what' }, headers: { 'X-GitHub-Event' => 'ping' })
      expect(last_response.status).to eq(200)
    end
  end
end
