class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      @teasers = Challenge.last(3)
      @user = User.new
    end
  end
end
