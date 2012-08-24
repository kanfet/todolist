require 'spec_helper'

describe MainController do

  describe "GET #index" do
    it do
      get :index
      should render_template :index
    end
  end
end