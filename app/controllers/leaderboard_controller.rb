class LeaderboardController < ApplicationController
  def show
    @users = User.where('points > 0').order('points DESC')
  end
end
