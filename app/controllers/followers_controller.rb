# frozen_string_literal: true

class FollowersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end
end
