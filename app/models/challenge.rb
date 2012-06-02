class Challenge < ActiveRecord::Base
  belongs_to :user

  validates :email, :presence => true, :email => true
  validates :user_id, :presence => true

  def send_challenge_email
    ChallengeMailer.challenge(self).deliver
  end
end
