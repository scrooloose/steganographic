class ChallengesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = current_user.challenges.new
  end

  def create
    @challenge = current_user.challenges.new(params[:challenge])
    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      @challenge.send_challenge_email
      redirect_to dashboard_path
    else
      render :action => 'new'
    end
  end
end
