require 'rails_helper'

describe ActionParamFixer do
  it 'rewrites action parameter to save it from being overwritten' do
    get('/?action=blue')
    expect(response.status).to eq(200)
  end
end
