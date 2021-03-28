class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :address, :company_name, :photo, :profession])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :first_name, :last_name, :address, :company_name, :photo, :profession])
  end
end
