class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me

  has_many :challenges
  has_many :responses

  after_initialize do |user|
    user.points ||= 0
  end

  def to_s
    "#{id} - #{email}"
  end

  def leaderboard_email
    email.sub(/@.*/, '@...')
  end

  def next_challenge
    challenges_to_try.first
  end

  def challenges_to_try
    #the first subquery detects challenges that havent been attempted
    #the second detects challenges that have been detected but have not been completed
    Challenge.where("(SELECT COUNT(*) FROM responses WHERE responses.challenge_id = challenges.id AND responses.user_id = ? ) = 0 OR (SELECT COUNT(*) FROM responses WHERE responses.challenge_id = challenges.id AND responses.user_id = ? AND correct IS NULL)", id, id)
  end
end
