# Handles incoming  hooks from GitHub
module Api
  module V1
    class GithubController < ApiController
      before_action :find_repository

      def webhook
        Rails.logger.info("Action: #{params[:webhook_action]}")

        if trigger?
          repository.triggers.each do |trigger|
            trigger.handle(github_event, params)
          end
        end

        render json: { accepted: 'true' }, status: :ok
      end

      private

      def repository
        @repository
      end

      def find_repository
        return unless params[:repository]
        @repository = Repository.find_by(name: params[:repository][:full_name])
        render(json: { not_found: params[:repository][:full_name] }, status: :not_found) unless @repository
      end

      def github_event
        request.headers['X-GitHub-Event']
      end

      def trigger?
        github_event == 'pull_request'
      end
    end
  end
end


