# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:first)
    @user = users(:user1)
    login_as(@user)
  end

  test "creating a report" do
    assert_difference("Report.count", 1) do
      visit root_path
      click_on "レポートを追加"
      fill_in "レポートタイトル", with: "new report"
      fill_in "レポート内容", with: "I have a good day!"
      click_button "登録する"
    end
    assert_text "新規作成されました"
  end

  test "show a report" do
    visit report_path(@report.id)
    assert_text "レポート：Myreport"
  end

  test "update a report" do
    visit report_path(@report.id)
    click_on "編集"
    fill_in "レポートタイトル", with: "レポートタイトル変更"
    fill_in "レポート内容", with: "レポートコンテント変更"
    click_button "更新する"
    assert_text "更新されました"
  end

  test "delete a report" do
    visit report_path(@report.id)
    click_on "削除"
    page.driver.browser.switch_to.alert.accept
    assert_text "削除されました"
    assert_nil(Report.find_by(id: @report.id))
  end
end
