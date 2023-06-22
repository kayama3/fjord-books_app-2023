# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    user = User.create!(email: 'hoge@example.com', password: 'password')
    report = user.reports.create!(title: '今日の日報', content: '今日も頑張った')
    assert report.editable?(user)
  end

  test 'not_editable?' do
    user_hoge = User.create!(email: 'hoge@example.com', password: 'password')
    user_piyo = User.create!(email: 'piyo@example.com', password: 'password')
    report = user_hoge.reports.create!(title: '今日の日報', content: '今日も頑張った')
    assert_not report.editable?(user_piyo)
  end

  test 'created_on' do
    user = User.create!(email: 'hoge@example.com', password: 'password')
    report = user.reports.create!(title: '今日の日報', content: '今日も頑張った')
    assert_equal Time.current.to_date, report.created_on
  end
end
