require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "Creates user with valid email" do
    user = create(:user)
    assert user.persisted?
    assert_match Rails.application.config.email_regex, user.email
  end

  test "Fails to create user with no email" do
    user = build(:user, :no_email)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "Fails to create user with invalid email" do
    user = build(:user, :invalid_email)
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "Fails to create user with duplicate email" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email)

    assert user1.persisted?
    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end
end
