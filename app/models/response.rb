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
end
