class ChallengesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @challenges = current_user.challenges
  end

  def show
    @challenge = current_user.challenges.find(params[:id])
  end

  def new
    @challenge = current_user.challenges.new
  end

  def create
    @challenge = current_user.challenges.new(params[:challenge])
    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      @challenge.send_challenge_email
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
