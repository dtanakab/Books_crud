# frozen_string_literal: true

class FollowingsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @following = @user.following
  end
end
