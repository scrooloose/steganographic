class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_to_next_challenge(args = {})
    next_challenge = current_user.next_challenge
    if next_challenge
      redirect_to new_challenge_response_path(next_challenge), args
    else
      redirect_to new_challenge_path, :notice => "You have completed all the puzzles! Try creating one!"
    end
  end

  def redirect_to_response(challenge, args = {})
    resp = Response.find_by_user_id_and_challenge_id(current_user.id, challenge.id) || raise("No response found")
    redirect_to challenge_response_path(challenge, resp), args
  end

  def login_required
    unless current_user
      redirect_to root_url, :notice => "You gotta log in first"
    end
  end
end
