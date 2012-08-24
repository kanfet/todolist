require 'spec_helper'

describe ApplicationController do

  describe "#current_user" do
    it "returns logged in user" do
      user = create(:user)
      log_in user
      controller.try(:current_user).should eq(user)
    end

    it "returns nil when user is not logged in" do
      controller.try(:current_user).should be_nil
    end
  end
end