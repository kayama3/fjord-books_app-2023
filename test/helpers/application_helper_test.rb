# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "i18n_pluralize" do
    # 微妙かも
    # locale == :ja 前提でテスト書いてるけど、これじゃいかんか
    assert_equal '本', i18n_pluralize(Book.model_name.human.downcase)
    assert_not_equal 'books', i18n_pluralize(Book.model_name.human.downcase)
  end

  test "i18n_error_count" do
    # 上に同じく微妙そう
    assert_equal '3件のエラー', i18n_error_count(3)
    assert_not_equal '3 errors', i18n_error_count(3)
  end

  test "format_content" do
    content = "こんにちわ。\nいい天気ですね。\n今日の予定はなんですか。"
    assert_equal "こんにちわ。<br>いい天気ですね。<br>今日の予定はなんですか。", format_content(content)
  end
end
