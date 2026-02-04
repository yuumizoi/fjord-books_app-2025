# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "returns name when name exists" do
    user = User.new(email: "test@example.com", name: "田中太郎")
    assert_equal "田中太郎", user.name_or_email
  end
  test "returns name when name does not exist" do
    user = User.new(email: "test@example.com", name: "")
    assert_equal "test@example.com", user.name_or_email
  end
end
