# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    def login_required
      redirect_to new_user_session_path unless user_signed_in?
    end

  protected
    def configure_permitted_parameters
      added_attrs = [:username, :postcode, :address, :postcode, :introduction]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
    end

    def require_login
      unless user_signed_in?
        flash[:notice] = t("messages.login_needed")
        redirect_to root_url
      end
    end

    def identity_verification
      unless User.find_by(id: params[:id]) == current_user
        flash[:notice] = t("messages.userself_only")
        redirect_to books_url
      end
    end
end
