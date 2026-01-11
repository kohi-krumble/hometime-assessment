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

  test "Fails to create overlapping reservations" do
    create(:reservation, 
      start_at: Date.today + 1.week, 
      end_at: Date.today + 2.weeks, 
      status: :accepted
    )

    overlapping_reservation = build(:reservation, 
      start_at: Date.today + 10.days, 
      end_at: Date.today + 15.days
    )

    assert_not overlapping_reservation.valid?
    assert_includes overlapping_reservation.errors[:base], "selected date is not available"
  end

  test "Allows overlapping reservations if no accepted reservation exists" do
    create(:reservation, 
      start_at: Date.today + 1.week, 
      end_at: Date.today + 2.weeks, 
      status: :pending
    )

    overlapping_reservation = build(:reservation, 
      start_at: Date.today + 10.days, 
      end_at: Date.today + 15.days, 
      status: :pending
    )

    assert overlapping_reservation.valid?
  end

  test "Fails to update exsiting accepted reservation to overlap with another accepted reservation" do
    create(:reservation, 
      start_at: Date.today + 1.week, 
      end_at: Date.today + 2.weeks, 
      status: :accepted
    )

    another_reservation = create(:reservation, 
      start_at: Date.today + 3.weeks, 
      end_at: Date.today + 4.weeks, 
      status: :accepted,
      guest: create(:guest, email: "guest2@example.com")
    )

    another_reservation.start_at = Date.today + 10.days
    another_reservation.end_at = Date.today + 15.days

    assert_not another_reservation.valid?
    assert_includes another_reservation.errors[:base], "selected date is not available"
  end

  test "Successfully creates a reservation with custom details" do
    custom_details = {
      number_of_guests: 2,
      localized_description: "2 guests",
      number_of_adults: 2,
      number_of_children: 0,
      number_of_infants: 0
    }
    reservation = create(:reservation, details: custom_details)

    assert reservation.persisted?
    assert_equal custom_details, reservation.details.to_h
  end

  test "Fails to create a reservation without details" do
    reservation = build(:reservation, details: nil)

    assert_not reservation.valid?
    assert_includes reservation.errors[:details], "details can't be blank"
  end

  test "Fails to create a reservation with inconsistent guest counts in details" do
    inconsistent_details = {
      number_of_guests: 3,
      localized_description: "3 guests",
      number_of_adults: 2,
      number_of_children: 0,
      number_of_infants: 0
    }
    reservation = build(:reservation, details: inconsistent_details)

    assert_not reservation.valid?
    assert_includes reservation.errors[:details], "number_of_guests does not match the sum of adults, children, and infants"
  end

  test "Fails to create a reservation with non-positive number_of_guests in details" do
    invalid_details = {
      number_of_guests: 0,
      localized_description: "0 guests",
      number_of_adults: 0,
      number_of_children: 0,
      number_of_infants: 0
    }
    reservation = build(:reservation, details: invalid_details)

    assert_not reservation.valid?
    assert_includes reservation.errors[:details], "number_of_guests must be positive"
  end
end
