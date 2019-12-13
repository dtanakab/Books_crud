# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @comment = comments(:voice)
    @book = books(:comic)
    @user = users(:user2)
    login_as(@user)
    visit book_path(@book.id)
    fill_in "コメント内容", with: "new comment"
    click_button "登録する"
  end

  test "add comment" do
    assert_difference("Comment.count", 1) do
      visit book_path(@book.id)
      fill_in "コメント内容", with: "add comment"
      click_button "登録する"
      assert_text "新規作成されました"
      click_on "トップページに戻る"
    end
  end

  test "update comment" do
    visit book_path(@book.id)
    click_on "編集"
    fill_in "コメント内容", with: "コメント内容変更"
    click_button "更新する"
    assert_text "更新されました"
    click_on "トップページに戻る"
  end

  test "delete comment" do
    assert_difference("Comment.count", -1) do
      visit book_path(@book.id)
      click_on "削除"
      page.driver.browser.switch_to.alert.accept
      assert_text "削除されました"
      click_on "トップページに戻る"
    end
  end
end
