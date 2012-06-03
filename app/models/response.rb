class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  validates :user_id, :presence => true
  validates :challenge_id, :presence => true

  after_initialize do |response|
    if response.new_record?
      response.attempts = 0
    end
  end

  def points_for_this_attempt
    if attempts <= 1
      10
    elsif attempts == 2
      5
    elsif attempts == 3
      2
    else
      1
    end
  end
end
