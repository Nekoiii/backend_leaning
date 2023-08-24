module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # To prevent session hijacking
    # https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443
    session[:session_token] = user.session_token
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    # Equals to :
    # cookies[:remember_token] = { value: user.remember_token,expires: 20.years.from_now.utc }
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])  #* It's '=' not '==' here!
      # @current_user ||= User.find_by(id: user_id)
      user = User.find_by(id: user_id)
      @current_user ||= user if session[:session_token] == user.session_token
      # if user && session[:session_token] == user.session_token
      #   @current_user = user
      # end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      # if user &. authenticated?(cookies[:remember_token])
      if user &. authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    # Remember to use 'user &&' to handle 'nil'
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil  # Not necessary but for safety
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Store the URL only for GET requests to avoid potential issues (e.g:
  # when user manually deleted the session cookie, or the session has expired)
  # with non-GET methods after login.
  def store_location
    # request.original_url: https://apidock.com/rails/ActionDispatch/Request/original_url
    session[:forwarding_url] = request.original_url if request.get?
  end


end
