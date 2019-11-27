# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :login_required
  skip_before_action :login_required, if: :devise_controller?

  protected
    def configure_permitted_parameters
      added_attrs = %i[username postcode address postcode introduction image]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
    end

    def login_required
      unless user_signed_in?
        flash[:notice] = t("messages.login_needed")
        redirect_to new_user_session_path
      end
    end
end
