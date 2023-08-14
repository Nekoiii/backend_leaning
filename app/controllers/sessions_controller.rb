class SessionsController < ApplicationController
  before_action :set_title

  def set_title
    @title = 'Log In'
  end

  def new
  end

  def create
    # unprocessable_entity: Return 422 status code if the resource is not processable
    render 'new', status: :unprocessable_entity
  end

  def destroy
  end
  
end
