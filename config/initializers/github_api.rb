Rails.application.config.github_api_client = Octokit::Client.new(access_token: ENV['GITHUB_API_KEY'])
Rails.application.config.github_app_id = ENV['GITHUB_APP_ID']

def new_jwt_token
  private_key = OpenSSL::PKey::RSA.new(ENV['GITHUB_APP_PRIVATE_KEY'])

  payload = {}.tap do |opts|
    opts[:iat] = Time.now.to_i           # Issued at time.
    opts[:exp] = opts[:iat] + 600        # JWT expiration time is 10 minutes from issued time.
    opts[:iss] = Rails.application.config.github_app_id # Integration's GitHub identifier.
  end

  JWT.encode(payload, private_key, 'RS256')
end

if ENV['GITHUB_APP_PRIVATE_KEY']
  Rails.application.config.github_jwt_client = Octokit::Client.new(bearer_token: new_jwt_token)
end
