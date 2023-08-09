module UsersHelper 
  def avatar_for(user)
    user.avatar.attached? ? url_for(user.avatar) : asset_path('avatar-1.jpg')
  end
end
