# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  test "user can login and create report" do
    visit new_user_session_path
    fill_in 'Eメール', with: "one@example.com"
    fill_in 'パスワード', with: "password123"
    click_on 'ログイン'
    assert_text 'ログインしました'
  end
end
