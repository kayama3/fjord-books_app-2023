# frozen_string_literal: true

require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  test 'current user name' do
    user = User.create!(email: 'hoge@example.com', password: 'password')
    assert_equal 'hoge@example.com', current_user_name(user)

    user.name = 'alice'
    assert_equal 'alice', current_user_name(user)
  end
end
