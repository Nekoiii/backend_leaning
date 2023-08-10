module UsersHelper 
  def avatar_for(user)
    default_avatar_path=asset_path('avatar-1.jpg')
    user.avatar.attached? ? url_for(user.avatar) : default_avatar_path
  end

  def add_err_class(user,field_name)
    user.errors[field_name].any? ? 'err_field' : ''
  end
end
