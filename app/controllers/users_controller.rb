class UsersController < ApplicationController
  before_action :require_login
  before_action :identity_verification, only: [:show]

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end
