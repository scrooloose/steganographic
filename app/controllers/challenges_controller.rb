class ChallengesController < ApplicationController
  before_filter :authenticate_user!, :except => :show

  def show
    @challenge = Challenge.find(params[:id])
  end

  def new
    @challenge = current_user.challenges.new
    @image = Image.new
  end

  def create
    @challenge = current_user.challenges.new(params[:challenge])
    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      @challenge.send_challenge_email
      redirect_to new_challenge_path
    else
      @image = Image.new
      render :action => 'new'
    end
  end
end
