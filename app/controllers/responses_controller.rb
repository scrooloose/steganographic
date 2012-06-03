class ResponsesController < ApplicationController
  before_filter :load_challenge
  before_filter :load_response

  def new
    if @resp.correct
      redirect_to dashboard_path, :notice => "Oy! You have already solved this one!"
    end
  end

  def create
    @resp.attempts += 1

    if @challenge.correct_answer?(params[:answer])
      @resp.correct = true
      current_user.points += @resp.points_for_this_attempt
      current_user.save!
      redirect_to dashboard_path, :notice => "Good job! You truly PWN!"
    else
      flash.now[:notice] = "Guess again!"
      render :new
    end

    @resp.save!
  end

  protected

    def load_response
      @resp = Response.find_or_create_by_user_id_and_challenge_id(current_user.id, @challenge.id)
    end

    def load_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

end
