# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    user = User.create!(email: 'hoge@example.com', password: 'password')
    report = user.reports.create!(title: 'hogehoge', content: 'fugafuga')
    assert report.editable?(user)
  end

  test 'created_on' do
    user = User.create!(email: 'hoge@example.com', password: 'password')
    report = user.reports.create!(title: 'hogehoge', content: 'fugafuga')
    assert_equal Time.current.to_date, report.created_on
    assert true
  end
end
