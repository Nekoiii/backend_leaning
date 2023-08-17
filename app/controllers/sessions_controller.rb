class SessionsController < ApplicationController
  before_action :set_title

  def set_title
    @title = 'Log In'
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user &.authenticate(params[:session][:password])
      '''
      reset_session: https://techtechmedia.com/session-rails/
      セッションリプレイ攻撃（session replay attack）：https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443 
      セッションハイジャック( Session Hijacking)：https://www.ubsecure.jp/blog/session_hijacking 
      セッション固定攻撃（session fixation）：https://railsguides.jp/security.html#%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E5%9B%BA%E5%AE%9A%E6%94%BB%E6%92%83 
      '''
      reset_session  
      '''
      *Can not use params[:session][:remember_me] ? remember(@user) : forget(@user)
      here beacuse 0 will return true in ruby !!!!
      '''
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to @user
    else    
      # flash v.s flash.now: https://qiita.com/jackie0922youhei/items/405711d2a2f1c483cbf9
      flash.now[:danger] = 'Invalid email/password combination !'
      # unprocessable_entity: Return 422 status code if the resource is not processable
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    # see_other: Return 303 status code
    redirect_to root_url, status: :see_other
  end
  
end
