class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_to_next_challenge(args = {})
    redirect_to new_challenge_response_path(current_user.next_challenge), args
  end
end
