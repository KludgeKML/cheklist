require 'rails_helper'

describe Trigger do
  before do
    stub_octokit
    user = User.new(display_name: 'Fake')
    @repository = Repository.new(name: 'test/test', user: user)
  end

  describe '#handle' do
    it 'calls its checks when triggered and creates success status' do
      expect(@repository).to receive(:create_status)
      trigger = Trigger.create(description: 'fake trigger', repository: @repository, action: 'pull_request')
      trigger.checks.create(check_type: 'FileChanged')
      trigger.handle('pull_request', { number: 1 })
    end

    it 'calls its checks when triggered and creates failed status' do
      expect(@repository).to receive(:create_status)
      trigger = Trigger.create(description: 'fake trigger', repository: @repository, action: 'pull_request')
      trigger.checks.create(check_type: 'FileChanged')
      trigger.handle('pull_request', { number: 2 })
    end
  end
end