class SessionsController < ApplicationController

  respond_to :json

  def create
    #render json: {id: 1}
    render json: {errors: "Wrong username and/or password"}, status: 422
  end

  def destroy

  end
end