module UsersHelper
  def user_avatar(user)
    if user.avatar.attached?
      image_tag(user.avatar, class: 'avatar-img')
    elsif user.avatar_url
      image_tag(user.avatar_url, class: 'avatar-img')
    else
      content_tag(:p, user.initials, class: 'avatar-initials')
    end
  end
end
