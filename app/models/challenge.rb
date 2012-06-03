class Challenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :image_1, :class_name => "Image"
  belongs_to :image_2, :class_name => "Image"
  has_many :responses

  validates :image_1_id, :presence => true
  validates :image_2_id, :presence => true
  validates :email, :presence => true, :email => true
  validates :user_id, :presence => true
  validates :answer, :presence => true

  def self.newly_added(number, current_user)
    order('created_at DESC').where('user_id != ?', current_user.id).limit(number)
  end

  def send_challenge_email
    ChallengeMailer.challenge(self).deliver
  end

  def correct_answer?(guess)
    guess.downcase == self.answer.downcase
  end

  def hint_string(show_vowels)
    rv = answer.gsub(/\s+/, '|')

    if show_vowels
      rv.gsub!(/[bcdfghjklmnpqrstvwxyz_]/i, '_')
    else
      rv.gsub!(/\w/, '_')
    end
  end
end
