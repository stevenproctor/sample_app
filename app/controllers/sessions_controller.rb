class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    @title = "Sign in"
    flash.now[:error] = "Invalid email/password combination."
    render :new
  end

  def destroy

  end
end
