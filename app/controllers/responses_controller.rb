class ResponsesController < ApplicationController
  before_filter :load_challenge

  def new
  end

  def create
    if @challenge.correct_answer?(params[:answer])
      redirect_to new_challenge_path, :notice => "Good job! Now create one yourself!"
    else
      flash.now[:notice] = "Guess again!"
      render :new
    end
  end

  protected

    def load_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

end
