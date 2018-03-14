class HomepageController < ApplicationController
  def index
    @current_user = current_user
    if current_user
      if params[:refresh] == 'true'
        current_user.make_repo_records_from_installations
      end
      installs = current_user.list_available_installations
      @install_id = installs[0].id if installs.count > 0
    end
  end
end
