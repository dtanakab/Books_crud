# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @auth = OmniAuth::AuthHash.new(uid: "234", provider: "github")
    @not_existed_user = User.find_for_oauth(@auth)
    @user = users(:user1)
    @followed_user = users(:user2)
  end

  test "pull user information with uid and uprovider" do
    auth = OmniAuth::AuthHash.new(uid: "123", provider: "github")
    actual_user = User.find_for_oauth(auth)
    expected_user = users(:user_auth)
    assert_equal(expected_user, actual_user)
  end

  test "make dummy_email" do
    actual_email = @not_existed_user.email
    expected_email = "234-github@example.com"
    assert_equal(expected_email, actual_email)
  end

  test "make dummy_name" do
    actual_name = @not_existed_user.username
    expected_name = "name:234-github"
    assert_equal(expected_name, actual_name)
  end

  test "save user account with uid and uprovider" do
    assert @not_existed_user.persisted?
  end

  test "add following user" do
    @user.follow(@followed_user)
    assert_equal(@followed_user, @user.following.first)
  end

  test "create record of active_follow" do
    @user.follow(@followed_user)
    assert Follow.find_by(followed_id: @followed_user.id)
  end

  test "destroy record of active_follow" do
    @user.follow(@followed_user)
    @user.unfollow(@followed_user)
    assert_nil(Follow.find_by(followed_id: @followed_user.id))
  end

  test "check user follow or not to following user" do
    @user.follow(@followed_user)
    assert @user.following?(@followed_user)
  end

  test "check user follow or not to not following user" do
    assert_not @user.following?(@followed_user)
  end
end
