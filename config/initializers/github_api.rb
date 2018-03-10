Rails.application.config.github_api_client = Octokit::Client.new(access_token: ENV['GITHUB_API_KEY'])
