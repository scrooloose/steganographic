class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image_1, :class_name => "Image"
  belongs_to :image_2, :class_name => "Image"

  validates :image_1_id, :presence => true
  validates :image_2_id, :presence => true
  validates :email, :presence => true, :email => true
  validates :user_id, :presence => true
  validates :answer, :presence => true

  def self.newly_added(number)
    order('created_at DESC').limit(number)
  end

  def send_challenge_email
    ChallengeMailer.challenge(self).deliver
  end

  def correct_answer?(guess)
    guess == self.answer
  end

  def hint_string
    answer.gsub(/\s+/, '|').gsub(/\w/, '_')
  end
end
