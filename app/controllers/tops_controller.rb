# frozen_string_literal: true

class TopsController < ApplicationController
  def show
    users = current_user.following
    posts = Book.where(user: users) + Report.where(user: users)
    @posts = posts.sort_by { |post| post[:updated_at] }.reverse
  end
end
