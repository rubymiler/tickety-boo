module PagesHelper
  def links_container
    if user_signed_in?
      render 'shared/signed_in_nav_links'
    else
      render 'shared/logged_out_nav_links' unless current_page?('/signin') || current_page?('/signup')
    end
  end

  def action_container
    if user_signed_in?
      render 'shared/signed_in_nav_actions'
    else
      render 'shared/logged_out_nav_actions'
    end
  end
end
