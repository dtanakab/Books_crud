# frozen_string_literal: true

require "application_system_test_case"

class FollowsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @other_user = users(:user2)
    login_as(@user)
  end

  test "follow other user" do
    visit user_path(@other_user.id)
    assert_difference("Follow.count", 1) do
      click_button "Follow"
    end
    assert_text "フォロワー数：1"
  end

  test "unfollow other user" do
    visit user_path(@other_user.id)
    click_button "Follow"
    id = Follow.first.id
    click_button "Unfollow"
    assert_text "フォロワー数：0"
    assert_nil(Follow.find_by(id: id))
  end
end
