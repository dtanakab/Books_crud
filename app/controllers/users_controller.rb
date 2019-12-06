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
    @user = User.find_by(id: params[:id])
    @following = @user.following
  end

  def followers
    @user = User.find_by(id: params[:id])
    @followers = @user.followers
  end
end
