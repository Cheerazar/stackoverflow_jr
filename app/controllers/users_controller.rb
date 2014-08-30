class UsersController < ApplicationController

  def login
    @user = User.new
  end

  def signin
    @user = User.find_by(:username =>params[:username])
    if @user.password == params[:password]
      session[:user] = @user.id
      redirect_to user_path(@user)
    else
      render :login
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    if @user.save
      session[:user] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find params[:id]
    if @user.update_attribute :password, params[:password]
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    user=User.find params[:id]
    session[:user] = nil
    user.destroy
  end

  def signout
    session[:user] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email)
  end
end
