module SharedUsersTest
  extend ActiveSupport::Concern

  included do
    test "Creates user with valid email" do
      user = create(:user)
      assert user.persisted?
      assert_match EmailValidator::EMAIL_REGEX, user.email
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

    test "Fails to create user with no phone numbers" do
      user = build(:user, phone_numbers: [])
      assert_not user.valid?
      assert_includes user.errors[:phone_numbers], "should have at least one phone number"
    end

    test "Fails to create user with invalid phone numbers" do
      user = build(:user, phone_numbers: ["12345", "invalid_number"])
      assert_not user.valid?
      assert_includes user.errors[:phone_numbers], "12345 is not valid"
      assert_includes user.errors[:phone_numbers], "invalid_number is not valid"
    end
  end
end
