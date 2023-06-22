# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @report = reports(:rails_test)
    sign_in users(:alice)
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'Railsでテストを書くの課題提出完了'
    fill_in '内容', with: 'やっとおわった〜'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'Railsでテストを書くの課題提出完了'
    assert_text 'やっとおわった〜'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: 'Railsでテストを書くの課題提出完了'
    fill_in '内容', with: 'やっとおわった〜'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'Railsでテストを書くの課題提出完了'
    assert_text 'やっとおわった〜'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end
end
