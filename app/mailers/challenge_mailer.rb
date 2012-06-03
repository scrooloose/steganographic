require 'cgi'

class ChallengeMailer < ActionMailer::Base
  default :from => "martin.grenfell@gmail.com"

  def challenge(challenge)
    @challenge = challenge
    mail :to => challenge.email,
         :from => challenge.user.email
  end
end
