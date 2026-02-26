# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'valid with title and content' do
    user = User.new(email: 'test@example.com', password: 'password123')
    report = Report.new(title: '今日の日報', content: '今日はこれをやった', user:)
    assert report.valid?
  end
  test 'invalid without title' do
    user = User.new(email: 'test@example.com', password: 'password123')
    report = Report.new(title: '', content: '今日はこれをやった', user:)
    assert_not report.valid?
  end
  test 'invalid without content' do
    user = User.new(email: 'test@example.com', password: 'password123')
    report = Report.new(title: '今日の日報', content: '', user:)
    assert_not report.valid?
  end
  test 'editable by own user' do
    user = User.new(email: 'test@example.com', password: 'password123')
    report = Report.new(title: '今日の日報', content: '今日はこれをやった', user:)
    assert report.editable?(user)
  end
  test 'not editable by other user' do
    user1 = User.new(email: 'test1@example.com', password: 'password123')
    user2 = User.new(email: 'test2@example.com', password: 'password123')
    report = Report.new(title: '今日の日報', content: '今日はこれをやった', user: user1)
    assert_not report.editable?(user2)
  end
  test 'returns date from created_at' do
    user = User.new(email: 'test@example.com', password: 'password123')
    report = Report.new(title: '今日の日報', content: '今日はこれをやった', user:)
    report.save
    assert_equal Date.current, report.created_on
  end

  test 'should create mention when report contains other report url' do
    user = users(:one)
    other_report = reports(:one)
    report_url = "http://localhost:3000/reports/#{other_report.id}"
    report = Report.new(title: '言及テスト', content: "この記事を参考にしました #{report_url}", user:)
    assert_difference 'ReportMention.count', 1 do
      report.save
    end
  end

  test 'should update mentions when report content is updated' do
    user = users(:one)
    report = reports(:one)
    other_report = reports(:two)
    report_url = "http://localhost:3000/reports/#{other_report.id}"
    
    report.update!(content: "URLを追記しました #{report_url}")
    assert_includes report.reload.mentioning_reports, other_report
    assert_equal 1, report.mentioning_reports.count
    
    report.update!(content: "URLを消しました")
    assert_not_includes report.reload.mentioning_reports, other_report
    assert_equal 0, report.mentioning_reports.count
  end
end
