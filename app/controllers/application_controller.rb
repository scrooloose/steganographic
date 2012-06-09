class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_to_next_challenge(args = {})
    redirect_to new_challenge_response_path(current_user.next_challenge), args
  end

  def redirect_to_response(challenge, args = {})
    resp = Response.find_by_user_id_and_challenge_id(current_user.id, challenge.id) || raise("No response found")
    redirect_to challenge_response_path(challenge, resp), args
  end
end
