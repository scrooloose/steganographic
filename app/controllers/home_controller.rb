class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path
    else
      @teasers = Challenge.last(3)
      @user = User.new
      if params[:challenge_id]
        session[:challenge_id] = params[:challenge_id]
      end
    end
  end
end
