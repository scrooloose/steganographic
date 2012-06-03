class ResponsesController < ApplicationController
  before_filter :load_challenge

  def new
    if Response.find_by_user_id_and_challenge_id_and_correct(current_user.id, @challenge.id, true)
      redirect_to dashboard_path, :notice => "Oy! You have already solved this one!"
    end
  end

  def create
    resp = Response.find_or_create_by_user_id_and_challenge_id(current_user.id, @challenge.id)
    resp.attempts += 1

    if @challenge.correct_answer?(params[:answer])
      resp.correct = true
      current_user.points += resp.points_for_this_attempt
      current_user.save!
      redirect_to dashboard_path, :notice => "Good job! You truly PWN!"
    else
      flash.now[:notice] = "Guess again!"
      render :new
    end

    resp.save!
  end

  protected

    def load_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

end
