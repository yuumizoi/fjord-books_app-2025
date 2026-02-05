# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  test "user can login and create report" do
    visit new_user_session_path
    fill_in 'Eメール', with: "one@example.com"
    fill_in 'パスワード', with: "password123"
    click_on 'ログイン'
    assert_text 'ログインしました'
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: "テスト日報"
    fill_in '内容', with: "今日はテストを書きました"
    click_on '登録する'
    assert_text '日報が作成されました'
  end
end
