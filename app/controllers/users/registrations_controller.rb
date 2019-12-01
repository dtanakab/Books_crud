# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource_or_scope)
    flash[:notice] = t('messages.sign_up_successfully')
    books_url
  end
end
