class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about]


  def after_sign_in_path_for(resource)
    # about_path
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    # about_path
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
  # 本当はkeyはnameで良いはずだがsign_upができなくなったからemail追加した
end
