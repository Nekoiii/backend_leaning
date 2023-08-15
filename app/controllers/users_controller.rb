# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @records = @user.records
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.except(:avatar))
    if user_params[:avatar].present?
      @user.avatar.attach(user_params[:avatar])
    else
      # Using Rails.root to make sure the full path to the default avatar file is correct
      default_avatar_path = Rails.root.join('app', 'assets', 'images', 'avatar-1.jpg')
       # Using io: File.open to open the file and create an IO object to attach the file
      @user.avatar.attach(io: File.open(default_avatar_path), filename: 'avatar-1.jpg')
    end

    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar,
                       :password, :password_confirmation)
    end
  

end
