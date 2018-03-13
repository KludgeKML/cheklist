require 'rails_helper'

describe Api::V1::GithubController, type: :controller do
  describe 'hook' do
    it 'registers an anonymous pulse' do
      request.headers['X-GitHub-Event'] = 'ping'
      post(:webhook, params: { action: 'blue', data: {}.to_json, id: 'what' })
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
        request.headers['X-GitHub-Event'] = 'pull_request'
        request.headers['Content-Type'] = 'application/json'
        post(:webhook, params: { repository: { full_name: 'test/unknown' }, number: 1 })
        expect(response.status).to eq(404)
      end

      it 'handles a known repo' do
        request.headers['X-GitHub-Event'] = 'pull_request'
        request.headers['Content-Type'] = 'application/json'
        post(:webhook, params: { repository: { full_name: 'test/test' }, number: 1 })
        expect(response.status).to eq(200)
      end
    end
  end
end
