# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource_or_scope)
    flash[:notice] = t("messages.login_successfully")
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = t("messages.logout_successfully")
    root_path
  end
end
