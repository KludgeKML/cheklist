# Handles incoming  hooks from GitHub
module Api
  module V1
    class Api::V1::GithubController < ApiController
      def webhook
        Rails.logger.info("Event: #{github_event}")
        Rails.logger.info("Action: #{params[:webhook_action]}")

        if trigger?
          affected_repo = Repository.find_by(name: params[:repository][:full_name])
          return render(json: { not_found: params[:repository][:full_name] }, status: :not_found) unless affected_repo
          affected_repo.triggers.each do |trigger|
            trigger.handle(github_event, params)
          end
        end

        render json: { accepted: 'true' }, status: :ok
      end

      private

      def github_event
        request.headers['X-GitHub-Event']
      end

      def trigger?
        github_event == 'pull_request'
      end
    end
  end
end


