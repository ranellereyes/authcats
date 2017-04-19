class UsersController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(username: params[:user][:username])
    @user.password = params[:user][:password]

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  # private
  #
  # def user_params
  #   params.require(:user)
  #     .permit(:username, :password_digest, :session_token)
  # end
end
