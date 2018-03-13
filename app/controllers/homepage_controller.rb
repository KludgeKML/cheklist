class HomepageController < ApplicationController
  def index
    @display_name = current_user ? current_user.display_name : nil
  end
end
