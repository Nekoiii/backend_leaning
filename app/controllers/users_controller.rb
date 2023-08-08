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
  end

end
