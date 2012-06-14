class HomeController < ApplicationController
  before_filter :load_teasers

  def index
    if user_signed_in?
      if params[:challenge_id]
        redirect_to_challenge
      else
        redirect_to_challenge
      end
    else
      @user = User.new :email => params[:email]
      if params[:challenge_id]
        session[:challenge_id] = params[:challenge_id]
      end
    end
  end

  def signup_login
    if @user = User.find_by_email(params[:user][:email])
      login_existing_user
    else
      signup_new_user
    end
  end

  protected

    def login_existing_user
      if @user.valid_password?(params[:user][:password])
        sign_in(@user)
        redirect_to_challenge
      else
        flash.now[:notice] = "An account exists for this email, and has a different password."
        render "index"
      end
    end

    def signup_new_user
      @user = User.new(params[:user])
      if @user.save
        sign_in(@user)
        redirect_to_challenge
      else
        flash.now[:notice] = "There was an error creating your account! #{@user.errors.full_messages.first} "
        render "index"
      end
    end

    def redirect_to_challenge
      challenge_id = params[:challenge_id] || session[:challenge_id]
      if challenge_id
        Rails.logger.debug challenge_id.inspect
        redirect_to new_challenge_response_path(challenge_id.to_s), :notice => "Welcome! Try and solve this!"
        session.delete(:challenge_id)
      else
        redirect_to_next_challenge  :notice => "Welcome! Try and solve this!"
      end
    end

    def load_teasers
      @teasers = Challenge.last(3)
    end
end
