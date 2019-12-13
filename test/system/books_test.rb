# frozen_string_literal: true

include Warden::Test::Helpers
require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:comic)
    @user = users(:user1)
    login_as(@user)
  end

  test "creating a Book" do
    assert_difference("Book.count", 1) do
      visit root_path
      click_on "本の感想を追加"
      fill_in "本のタイトル", with: "newbook"
      fill_in "メモ", with: "interesting"
      fill_in "著者", with: "writer"
      attach_file "画像", "#{Rails.root}/test/fixtures/images/sample.png"
      click_button "登録する"
    end
    assert_text "新規作成されました"
    click_on "トップページに戻る"
  end

  test "show a Book" do
    visit book_path(@book.id)
    assert_text "「MyString」の感想"
    click_on "トップページに戻る"
  end

  test "update a Book" do
    visit book_path(@book.id)
    click_on "編集"
    fill_in "本のタイトル", with: "タイトル変更"
    fill_in "メモ", with: "メモ変更"
    fill_in "著者", with: "著者変更"
    attach_file "画像", "#{Rails.root}/test/fixtures/images/sample2.png"
    click_button "更新する"
    assert_text "更新されました"
  end

  test "delete a Book" do
    assert_difference("Book.count", -1) do
      visit book_path(@book.id)
      click_on "削除"
      page.driver.browser.switch_to.alert.accept
      assert_text "削除されました"
      click_on "トップページに戻る"
    end
  end
end
