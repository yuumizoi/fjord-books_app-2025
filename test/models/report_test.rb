# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "valid with title and content" do
    user = User.new(email: "test@example.com", password: "password123")
    report = Report.new(title: "今日の日報", content: "今日はこれをやった", user: user)
    assert report.valid?
  end
  test "invalid without title" do
    user = User.new(email: "test@example.com", password: "password123")
    report = Report.new(title: "", content: "今日はこれをやった", user: user)
    assert_not report.valid?
  end
  test "invalid without content" do
    user = User.new(email: "test@example.com", password: "password123")
    report = Report.new(title: "今日の日報", content: "", user: user)
    assert_not report.valid?
  end
  test "editable by own user" do
    user = User.new(email: "test@example.com", password: "password123")
    report = Report.new(title: "今日の日報", content: "今日はこれをやった", user: user)
    assert report.editable?(user)
  end
end
