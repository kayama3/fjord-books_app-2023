# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'i18n pluralize' do
    I18n.default_locale = :ja
    assert_equal '本', i18n_pluralize(Book.model_name.human.downcase)

    I18n.default_locale = :en
    assert_equal 'books', i18n_pluralize(Book.model_name.human.downcase)
  end

  test 'i18n error ount' do
    I18n.default_locale = :ja
    assert_equal '3件のエラー', i18n_error_count(3)

    I18n.default_locale = :en
    assert_equal '3 errors', i18n_error_count(3)
  end

  test 'format content' do
    content = "こんにちわ。\nいい天気ですね。\n今日の予定はなんですか。"
    assert_equal 'こんにちわ。<br>いい天気ですね。<br>今日の予定はなんですか。', format_content(content)
  end
end
