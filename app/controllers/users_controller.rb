# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show following followers reports]

  def index
    @users = User.all
  end

  def show
    if @user
      set_posts(@user.id)
      render 'users/mypage' if @user == current_user
    end
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  def reports
    @reports = @user.reports
  end

  def top
    set_posts(current_user.following)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_posts(users)
    posts = Book.where(user: users) + Report.where(user: users)
    @posts = posts.sort_by { |post| post[:updated_at] }.reverse
  end
end
