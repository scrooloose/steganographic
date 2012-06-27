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
    challenges_to_try.order('RAND()').first
  end

  def incomplete_beginner_challenges
    Challenge.for_beginners.where(
      "challenges.user_id != :user_id " +
      "AND (NOT EXISTS (SELECT * FROM responses,users where responses.challenge_id = challenges.id AND responses.user_id = users.id AND user_id = :user_id) " +
      "OR EXISTS (SELECT * FROM responses,users where responses.challenge_id = challenges.id AND responses.user_id = users.id AND user_id = :user_id AND (responses.correct IS NULL OR responses.correct = :false)))",
      :user_id => id, :false => false)
  end

  def completed_all_beginner_challenges?
    incomplete_beginner_challenges.empty?
  end

  def challenges_to_try
    beginner_challenges = incomplete_beginner_challenges
    return beginner_challenges if beginner_challenges.any?

    #the first subquery detects challenges that havent been attempted
    #the second detects challenges that have been detected but have not been completed
    Challenge.where(
      "challenges.user_id != :c_uid " +
      "AND (SELECT COUNT(*) FROM responses WHERE responses.challenge_id = challenges.id AND responses.user_id = :c_uid ) = 0 " +
      "OR (SELECT COUNT(*) FROM responses WHERE responses.challenge_id = challenges.id AND responses.user_id = :c_uid AND correct IS NULL)", :c_uid => id)
  end
end
