# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  protected
    def configure_permitted_parameters
      added_attrs = %i[username postcode address postcode introduction image]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
    end

    def login_required
      unless user_signed_in?
        flash[:notice] = t("messages.login_needed")
        redirect_to books_url
      end
    end

    def identity_verification
      unless User.find_by(id: params[:id]) == current_user
        flash[:notice] = t("messages.userself_only")
        redirect_to books_url
      end
    end
end
