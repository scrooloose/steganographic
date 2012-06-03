class DashboardController < ApplicationController
  def show
    if session[:challenge_id]
      redirect_to new_challenge_response_path(session[:challenge_id])
      session[:challenge_id] = nil
    end
  end
end
