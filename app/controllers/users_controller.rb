# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit update]
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def set_user
    @user = User.find(params[:id])
  end


  def index
    @users = User.all
  end

  def show
    @records = @user.records
    # debugger
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

  def edit
  end

  def update
    Rails.logger.debug('update-user')
    if user_params[:avatar].present?
      @user.avatar.attach(user_params[:avatar])
    end
    
    if @user.update(user_params)
      flash[:success] = "Profile was successfully updated."
      redirect_to @user
    else
      Rails.logger.debug('xxxxx-update-user')
      Rails.logger.debug(@user.errors.full_messages.join("\n"))
      render :edit, status: :unprocessable_entity
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  def correct_user
    @user = User.find(params[:id])
    # current_user?() is the method defined in sessions_helper.rb
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :avatar,
                       :password, :password_confirmation)
    end
  

end
