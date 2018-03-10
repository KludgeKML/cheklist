# Handles incoming  hooks from GitHub
module Api
  module V1
    class Api::V1::GithubController < ApiController
      def hook
        Rails.logger.info("Event: #{request.headers['X-GitHub-Event']}")
        Rails.logger.info("Action: #{params[:webhook_action]}")

        if request.headers['X-GitHub-Event'] == 'pull_request'
          validator = VersionValidator.new()
          validator.validate(params[:repository][:full_name], params[:number])
        end

        render json: { accepted: 'true' }, status: :ok
      end
    end
  end
end


