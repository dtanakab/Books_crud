# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :login_required
  before_action :identity_verification, only: [:show]

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end
