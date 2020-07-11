module UsersHelper
  def show_avatar(resource)
    if resource.avatar.attached?
      image_tag(resource.avatar_url, class: 'avatar-img')
    elsif resource.avatar_url
      image_tag(resource.avatar_url, class: 'avatar-img')
    else
      render 'devise/shared/avatar'
    end
  end
end
