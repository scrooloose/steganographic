class ResponsesController < ApplicationController
  before_filter :load_challenge

  def new
    if Response.find_by_user_id_and_challenge_id_and_correct(current_user.id, @challenge.id, true)
      redirect_to dashboard_path, :notice => "Oy! You have already solved this one!"
    end
  end

  def create
    response = Response.find_or_create_by_user_id_and_challenge_id(current_user.id, @challenge.id)
    response.attempts = response.attempts + 1

    if @challenge.correct_answer?(params[:answer])
      response.correct = true
      redirect_to dashboard_path, :notice => "Good job! You truly PWN!"
    else
      flash.now[:notice] = "Guess again!"
      render :new
    end

    response.save!
  end

  protected

    def load_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

end
