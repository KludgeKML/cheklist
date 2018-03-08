class Api::V1::GithubController < ApplicationController
  def hook
    Rails.logger.info("Event-type: #{request.headers['X-GitHub-Event']}")
    
    params.each do |k, v|
      Rails.logger.info("Param[#{k}] : #{v}")
    end
    
    render json: { accepted: 'true' }, status: :ok
  end
end
