class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # error handling: https://medium.com/spritle-software/handle-activerecord-recordnotfound-more-elegantly-11891c80a644

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def handle_record_not_found
    redirect_to main_app.root_url, alert: "Resource doesn't exist"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name avatar])
  end
end
