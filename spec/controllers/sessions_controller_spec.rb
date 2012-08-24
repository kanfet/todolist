require 'spec_helper'

describe SessionsController do

  describe "POST #create" do

    context "with valid username and password" do
      before(:each) do
        @user = create(:user)
        post :create, username: @user.username, password: @user.password
      end

      it "saves user's id in session" do
        session[:user_id].should eq(@user.id)
      end

      it "returns username as json" do
        response.body.should eq({user: @user.username}.to_json)
      end
    end

    context "with invalid username and password" do
      before(:each) do
        @user = create(:user)
        post :create, username: @user.username, password: "it is invalid password"
      end

      it "does not save user's id in session" do
        session[:user_id].should_not eq(@user.id)
      end

      it "returns errors as json" do
        JSON.parse(response.body)['errors'].should_not be_nil
      end
    end
  end

  describe "DELETE #destroy" do

    it "clears user's id in session" do
      delete :destroy, id: "any"
      session[:user_id].should be_nil
    end
  end
end