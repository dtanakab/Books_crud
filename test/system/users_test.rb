# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @other_user = users(:user2)
  end

  test "creating a user" do
    assert_difference("User.count", 1) do
      visit new_user_registration_path
      click_on "会員登録"
      fill_in "ユーザーネーム", with: "testusername"
      fill_in "メールアドレス", with: "test@gmail.com"
      fill_in "郵便番号", with: 9999999
      fill_in "住所", with: "America"
      fill_in "自己紹介", with: "Good Morning"
      attach_file "画像", "#{Rails.root}/test/fixtures/images/sample.png"
      fill_in "パスワード", with: "password"
      fill_in "パスワード(再確認のため)", with: "password"
      click_button "会員登録"
      assert_text "会員登録できました"
    end
  end

  test "sign in user" do
    visit new_user_session_path
    fill_in "メールアドレス", with: @user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    assert_text "ログインできました"
  end

  test "sign out user" do
    login_as(@user)
    visit root_path
    click_on "ログアウト"
    visit root_path
    assert_text "ログインが必要です"
  end

  test "show toppage" do
    login_as(@user)
    visit root_path
    assert_text "Rails練習用アプリ"
  end

  test "show mypage" do
    login_as(@user)
    visit user_path(@user.id)
    assert_text @user.address
    click_on "トップページに戻る"
  end

  test "show user index and check show other user page" do
    login_as(@user)
    visit root_path
    click_on "会員一覧"
    assert_text "会員一覧"
    click_on @other_user.username
    assert_text @other_user.username
    click_on "トップページに戻る"
  end

  test "show other user's follower" do
    login_as(@user)
    visit user_path(@other_user.id)
    click_button "Follow"
    click_on "フォロワー数：1"
    assert_text @user.username
    click_on "トップページに戻る"
  end

  test "show user's following" do
    login_as(@user)
    visit user_path(@other_user.id)
    click_button "Follow"
    visit user_path(@user.id)
    click_on "フォロー数：1"
    assert_text @other_user.username
  end
end
