Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end

# Monkeypatch the github strategy so that it doesn't include
# params in the redirect URL during the callback phase (which
# causes Github to complain)

require 'omniauth-github'

module OmniAuth
  module Strategies
    class GitHub < OmniAuth::Strategies::OAuth2
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
