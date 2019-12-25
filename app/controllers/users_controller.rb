# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = User.all
  end

  def show
    if @user
      posts = Book.where(user: @user)
      @posts = posts.sort_by { |post| post[:updated_at] }.reverse
      render "users/mypage" if @user == current_user
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
