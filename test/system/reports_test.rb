# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  def login
    visit new_user_session_path
    fill_in 'Eメール', with: "one@example.com"
    fill_in 'パスワード', with: "password123"
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test "user can login and create report" do
    login
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: "テスト日報"
    fill_in '内容', with: "今日はテストを書きました"
    click_on '登録する'
    assert_text '日報が作成されました'
  end
  
  test "user can edit report" do
    login
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: "編集前のタイトル"
    fill_in '内容', with: "編集前の内容"
    click_on '登録する'
    
    click_on 'この日報を編集'
    fill_in 'タイトル', with: "編集後のタイトル"
    click_on '更新する'
    assert_text '日報が更新されました'
  end

  test "user can delete report" do
    login
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: "削除するタイトル"
    fill_in '内容', with: "削除する内容"
    click_on '登録する'
    click_on 'この日報を削除'
    assert_text '日報が削除されました'
  end
end
