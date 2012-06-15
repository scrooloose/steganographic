require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "GET index" do
    should "succeed" do
      get :index
      assert_response :success
    end

    context "when a challenge_id is passed" do
      setup do
        @user = FactoryGirl.create(:user)
        FactoryGirl.create(:challenge)
        @challenge = FactoryGirl.create(:challenge)
        FactoryGirl.create(:challenge)
      end

      should "when logged in it redirects to the challenge" do
        sign_in(@user)
        get :index, :challenge_id => @challenge.id
        assert_redirected_to new_challenge_response_path(@challenge)
      end

      should "when not logged in render the index page and store the challenge_id in the session" do
        get :index, :challenge_id => @challenge.id
        assert_response :success
        assert_equal session[:challenge_id].to_i, @challenge.id
      end
    end


  end

  context "POST signup_login" do

    context "when a challenge_id is stored" do
      setup do
        FactoryGirl.create(:challenge)
        @challenge = FactoryGirl.create(:challenge)
        FactoryGirl.create(:challenge)
        session[:challenge_id] = @challenge.id
      end

      context "with a new user" do
        should "redirect to the challenge" do
          post :signup_login, :user => {:email => "new@user.com", :password => "foobar" }
          assert_redirected_to new_challenge_response_path(@challenge)
        end

        should "sign in the user" do
          post :signup_login, :user => {:email => "new@user.com", :password => "foobar" }
          assert_equal @controller.current_user.email, "new@user.com"
        end
      end

      context "with an existing user" do
        setup do
          @user = FactoryGirl.create(:user, :email => "existing@user.com")
        end

        should "log in the user" do
          post :signup_login, :user => {:email => "existing@user.com", :password => "foobar" }
          assert_equal @controller.current_user.email, "existing@user.com"
        end

        should "redirect to the challenge" do
          post :signup_login, :user => {:email => "existing@user.com", :password => "foobar" }
          assert_redirected_to new_challenge_response_path(@challenge)
        end
      end

    end

    setup do
      @challenge1 = FactoryGirl.create(:challenge)
      @challenge2 = FactoryGirl.create(:challenge)

    end

    context "with a new user" do
      should "create the user" do
        post :signup_login, :user => { :email => "new@user.com", :password => "foobar" }
        assert_equal User.last.email, "new@user.com"
      end

      should "redirect them to the first challenge" do
        post :signup_login, :user => { :email => "new@user.com", :password => "foobar" }
        assert_redirected_to new_challenge_response_path(@challenge1)
      end
    end

    context "with an existing user" do
      should "redirect them to their next challenge" do
        FactoryGirl.create(:user, :email => "existing@user.com")
        post :signup_login, :user => { :email => "existing@user.com", :password => "foobar" }
        assert_redirected_to new_challenge_response_path(@challenge1)
      end
    end

    should "render the index page again with a flash if they try to log in with the wrong password" do
        FactoryGirl.create(:user, :email => "existing@user.com", :password => "foobar")
        post :signup_login, :user => { :email => "existing@user.com", :password => "wrong password" }
        assert_template :index
        assert_not_nil flash[:notice]
    end
  end



end
