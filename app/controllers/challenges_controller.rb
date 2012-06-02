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
      redirect_to @challenge
    else
      render :action => 'new'
    end
  end

  def edit
    @challenge = current_user.challenges.find(params[:id])
  end

  def update
    @challenge = current_user.challenges.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      flash[:notice] = "Successfully updated challenge."
      redirect_to @challenge
    else
      render :action => 'edit'
    end
  end

  def destroy
    @challenge = current_user.challenges.find(params[:id])
    @challenge.destroy
    flash[:notice] = "Successfully destroyed challenge."
    redirect_to challenges_url
  end

end
