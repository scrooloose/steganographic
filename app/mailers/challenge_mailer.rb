require 'cgi'

class ChallengeMailer < ActionMailer::Base
  default :from => "martin.grenfell@gmail.com"

  def challenge(challenge, email=nil)
    @challenge = challenge
    @email = email
    mail :to => email || challenge.email,
         :from => challenge.user.email,
         :subject => "A Challenge from the Impossible Mission Force"
  end
end
