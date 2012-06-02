class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image_1, :class_name => "Image"
  belongs_to :image_2, :class_name => "Image"

  validates :image_1_id, :presence => true
  validates :image_2_id, :presence => true
  validates :email, :presence => true, :email => true
  validates :user_id, :presence => true

  def send_challenge_email
    ChallengeMailer.challenge(self).deliver
  end
end
