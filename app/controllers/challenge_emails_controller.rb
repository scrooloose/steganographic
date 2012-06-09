class ChallengeEmailsController < ApplicationController
  def create
    @email = params[:email] || (return render(:text => "email expected"))
    @challenge = Challenge.find(params[:challenge_id])
    ChallengeMailer.challenge(@challenge, @email).deliver

    redirect_to_response @challenge, :notice => "Your email has been sent!"
  end
end
