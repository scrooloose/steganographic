class HomeController < ApplicationController
  def index
    @teasers = Challenge.last(3)
    @user = User.new
  end
end
