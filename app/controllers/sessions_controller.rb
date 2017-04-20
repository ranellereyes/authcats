class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      fail
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
