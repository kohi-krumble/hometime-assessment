require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "Successfully creates a reservation when all required fields are provided" do
    reservation = create(:reservation)

    assert reservation.persisted?
  end

  test "Fails to create a reservation without a guest" do
    reservation = build(:reservation, guest: nil)

    assert_not reservation.valid?
    assert_includes reservation.errors[:guest], "must exist"
  end

  test "Fails to create a reservation with start_at in the past" do
    reservation = build(:reservation, start_at: Date.yesterday)

    assert_not reservation.valid?
    assert_includes reservation.errors[:start_at], "must be greater than #{Date.current}"
  end

  test "Fails to create a reservation with end_at before start_at" do
    reservation = build(:reservation, start_at: Date.today + 1.week, end_at: Date.today + 1.day)

    assert_not reservation.valid?
    assert_includes reservation.errors[:end_at], "must be after the start date"
  end

  test "Fails to create a reservation with non-positive no_of_nights" do  
    reservation = build(:reservation, no_of_nights: 0)

    assert_not reservation.valid?
    assert_includes reservation.errors[:no_of_nights], "must be greater than 0"
  end
  
  test "Fails to create a reservation without currency" do
    reservation = build(:reservation, currency: nil)

    assert_not reservation.valid?
    assert_includes reservation.errors[:currency], "can't be blank"
  end

  test "Fails to create a reservation with negative payout_amount" do
    reservation = build(:reservation, payout_amount: -100.00)

    assert_not reservation.valid?
    assert_includes reservation.errors[:payout_amount], "must be greater than or equal to 0"
  end

  test "Fails to create a reservation with negative security_amount" do
    reservation = build(:reservation, security_amount: -50.00)

    assert_not reservation.valid?
    assert_includes reservation.errors[:security_amount], "must be greater than or equal to 0"
  end

  test "Fails to create a reservation with negative total_amount" do
    reservation = build(:reservation, total_amount: -200.00)

    assert_not reservation.valid?
    assert_includes reservation.errors[:total_amount], "must be greater than or equal to 0"
  end

  test "Successfully creates reservations with different statuses" do
    %w[pending accepted completed].each do |status|
      reservation = build(:reservation, status: status)
      assert reservation.valid?
    end
  end

  test "Fails to create a reservation with an invalid status" do
    assert_raises(ArgumentError, match: /'invalid_status' is not a valid status/) do
      create(:reservation, status: "invalid_status")
    end
  end
end
