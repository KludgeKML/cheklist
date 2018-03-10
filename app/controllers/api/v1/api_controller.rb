# Base class for Api V1 - doesn't derive from ApplicationController
module Api
  module V1
    class ApiController < ActionController::Base
      skip_before_action :verify_authenticity_token
    end
  end
end
