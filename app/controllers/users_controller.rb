require 'bcrypt'

class UsersController < ApplicationController

  def login
    @user = User.new
  end

  def index
    @users = User.all
  end

  def signin
    @user = User.find_by_username(params[:username])
    user_hash = BCrypt::Password.new(@user.password_hash)

    if @user && @user[:password_hash] == user_hash
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
    hash = BCrypt::Password.create(params[:password])
    @user.password_hash = hash

    if @user.save
      session[:user] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def edit
    @user=User.find(params[:id])
    if session[:user] == @user.id
      @user=User.find(params[:id])
    else
      redirect_to root_path
    end
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
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password_hash)
  end

end
