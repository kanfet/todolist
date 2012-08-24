require 'spec_helper'

describe User do

  describe "valid user" do
    subject { create :user }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }

    it { should validate_uniqueness_of(:username) }
  end

  describe "#authenticate" do

    context "with exist user" do
      it "should return this user" do
        user = create :user
        authenticated_user = User.authenticate(user.username, user.password)
        authenticated_user.should_not be_nil
        authenticated_user.username.should eq(user.username)
      end
    end

    context "with non-exist user" do
      it "should return nil" do
        authenticated_user = User.authenticate("chuck norris", "123")
        authenticated_user.should be_nil
      end
    end

    context "with wrong user/password combination" do
      it "should return nil" do
        user = create :user
        authenticated_user = User.authenticate(user.username, "123")
        authenticated_user.should be_nil
      end
    end
  end
end
