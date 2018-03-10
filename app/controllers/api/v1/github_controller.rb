# Handles incoming  hooks from GitHub
module Api
  module V1
    class Api::V1::GithubController < ApiController
      def hook
        Rails.logger.info("Event: #{request.headers['X-GitHub-Event']}")
        Rails.logger.log("Action: #{params[:action]}")

        if (request.headers['X-GitHub-Event'] == 'pull_request') && ['opened', 'edited', 'reopened'].include?(params[:action])
          validator = VersionValidator.new(params[:pull_request][:repo][:full_name], params[:number])
          validator.validate()
        end

        render json: { accepted: 'true' }, status: :ok
      end
    end
  end
end


