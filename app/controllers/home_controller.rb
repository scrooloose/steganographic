class HomeController < ApplicationController
  def index
    if user_signed_in?
      if params[:challenge_id]
        redirect_to new_challenge_response_path(params[:challenge_id])
      else
        redirect_to dashboard_path
      end
    else
      @teasers = Challenge.last(3)
      @user = User.new
      if params[:challenge_id]
        session[:challenge_id] = params[:challenge_id]
      end
    end
  end
end
