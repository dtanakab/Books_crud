# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    if @user
      set_posts(@user.id)
      render "users/mypage" if @user == current_user
    end
  end

  def top
    set_posts(User.all)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_posts(users)
      posts = Book.where(user: users)
      @posts = posts.sort_by { |post| post[:updated_at] }.reverse
    end
end
