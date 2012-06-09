class HomeController < ApplicationController
  before_filter :load_teasers

  def index
    if user_signed_in?
      if params[:challenge_id]
        redirect_to new_challenge_response_path(params[:challenge_id])
      else
        redirect_to_next_challenge :notice => "Hi there, can you solve this??!"
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
        redirect_to_next_challenge :notice => "Hi there, can you solve this??!"
      else
        flash.now[:notice] = "An account exists for this email, and has a different password."
        render "index"
      end
    end

    def signup_new_user
      @user = User.new(params[:user])
      if @user.save
        sign_in(@user)
        redirect_to_next_challenge  :notice => "Welcome! Try and solve this!"
      else
        flash.now[:notice] = "There was an error creating your account! #{@user.errors.full_messages.first} "
        render "index"
      end
    end

    def load_teasers
      @teasers = Challenge.last(3)
    end
end
