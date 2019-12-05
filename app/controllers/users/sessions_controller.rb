# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(_resource_or_scope)
    flash[:notice] = t("messages.login_successfully")
    books_url
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash[:notice] = t("messages.logout_successfully")
    books_url
  end
end
