class SessionsController < ApplicationController

  respond_to :json

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      render json: {user: user.username}
    else
      render json: {errors: "Wrong username and/or password"}, status: 422
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {}
  end
end