require 'spec_helper'

describe UsersController do

  describe "POST #create" do
    context "with valid attributes" do

      it "saves new user in database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "returns saved user as json" do
        user = attributes_for(:user)
        post :create, user: user, format: :json
        JSON.parse(response.body)['username'].should eq(user[:username])
      end
    end

    context "with invalid attributes" do

      it "does not save new user in database" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it "returns errors as json" do
        post :create, user: attributes_for(:invalid_user), format: :json
        JSON.parse(response.body)['errors'].should_not be_nil
      end
    end
  end
end
