# frozen_string_literal: true

require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @other_user = users(:user2)
    login_as(@user)
  end

  test "follow other user" do
    assert_difference("Relationship.count", 1) do
      visit user_path(@other_user.id)
      click_button "Follow"
      assert_text "フォロワー数：1"
      click_on "トップページに戻る"
    end
  end

  test "unfollow other user" do
    visit user_path(@other_user.id)
    click_button "Follow"
    assert_difference("Relationship.count", -1) do
      click_button "Unfollow"
      assert_text "フォロワー数：0"
      click_on "トップページに戻る"
    end
  end
end
