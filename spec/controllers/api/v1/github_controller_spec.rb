require 'rails_helper'

describe Api::V1::GithubController, type: :controller do  
  describe 'hook' do
    it 'registers an anonymous pulse' do
      request.headers['X-GitHub-Event'] = 'ping'
      post(:webhook, params: { data: {}.to_json, id: 'what' })	
      expect(response.status).to eq(200)
    end
  end
end
