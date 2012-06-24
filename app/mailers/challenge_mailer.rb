require 'cgi'

class ChallengeMailer < ActionMailer::Base
  default :from => "noreply@impossiblemissionforce.co.uk"

  def challenge(challenge, email=nil, from_email=nil)
    @challenge = challenge
    @email = email
    mail :to => email || challenge.email,
         :from => from_email || challenge.user.email,
         :subject => "A Challenge from the Impossible Mission Force"
  end
end
