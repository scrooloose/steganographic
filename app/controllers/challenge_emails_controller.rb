class ChallengeEmailsController < ApplicationController
  before_filter :login_required

  def create
    @email = params[:email] || (return render(:text => "email expected"))
    @challenge = Challenge.find(params[:challenge_id])
    ChallengeMailer.challenge(@challenge, @email, current_user.email).deliver

    redirect_to_response @challenge, :notice => "Your email has been sent!"
  end
end
