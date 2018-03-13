require 'rails_helper'

describe Api::V1::GithubController, type: :controller do
  before do
    Rails.application.config.github_webhook_secret = 'test-secret'
  end

  describe '<signature verification>' do
    context 'with no local secret' do
      it 'fails' do
        data = { action: 'blue', data: {}.to_json, id: 'what' }
        headers_for_data(request, data, event_type: 'ping')
        Rails.application.config.github_webhook_secret = nil
        post(:webhook, params: data)
        expect(response.status).to eq(401)
      end
    end

    context 'with no remote signature' do
      it 'fails' do
        data = { action: 'blue', data: {}.to_json, id: 'what' }
        headers_for_data(request, data, event_type: 'ping')
        request.headers['HTTP_X_HUB_SIGNATURE'] = nil
        post(:webhook, params: data)
        expect(response.status).to eq(401)
      end
    end

    context 'with mismatched secret' do
      it 'fails' do
        data = { action: 'blue', data: {}.to_json, id: 'what' }
        headers_for_data(request, data, event_type: 'ping')
        Rails.application.config.github_webhook_secret = 'wrong-secret'
        post(:webhook, params: data)
        expect(response.status).to eq(401)
      end
    end
  end

  describe '#hook' do
    it 'registers an anonymous pulse' do
      data = { action: 'blue', data: {}.to_json, id: 'what' }
      headers_for_data(request, data, event_type: 'ping')
      post(:webhook, params: data)
      expect(response.status).to eq(200)
    end

    context 'with a pull request' do
      before do
        stub_octokit
        repo = Repository.create(name: 'test/test', user: User.create)
        trigger = repo.triggers.create(action: 'pull_request', target: '*')
        trigger.checks.create(check_type: 'FileChanged')
        trigger.checks.create(check_type: 'MergeFrom')
      end

      it 'returns not found for an unknown repo' do
        data = { repository: { full_name: 'test/unknown' }, number: 1 }
        headers_for_data(request, data, event_type: 'pull_request')

        post(:webhook, params: data)
        expect(response.status).to eq(404)
      end

      it 'handles a known repo' do
        data = { repository: { full_name: 'test/test' }, number: 2 }
        headers_for_data(request, data, event_type: 'pull_request')

        post(:webhook, params: data)
        expect(response.status).to eq(200)
      end
    end
  end
end
