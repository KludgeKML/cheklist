require 'rails_helper'

describe ActionParamFixer do
  it 'rewrites action parameter to save it from being overwritten' do
    post('/api/v1/github/webhook',
      params: {
        action: 'blue',
        data: {}.to_json,
        id: 'what'
      },
      headers: {
        'X-GitHub-Event' => 'ping'
      }
    )
    expect(response.status).to eq(200)
  end
end
