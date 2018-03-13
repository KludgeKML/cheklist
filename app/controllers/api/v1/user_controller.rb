# Handles incoming  hooks from GitHub
module Api
  module V1
    class UserController < ApiController
      def index
        users = []
        User.all.each do |user|
          users << { display_name: user.display_name }
        end
        render json: { users: users }, status: :ok
      end
    end
  end
end
