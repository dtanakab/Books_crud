# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :login_required

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
    @books = @user.books if @user
  end

  def following
    @users = current_user.following
  end

  def followers
    @users = current_user.followers
  end
end
