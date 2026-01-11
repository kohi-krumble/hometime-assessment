class Reservation::PayloadV2
  def initialize(payload)
    @payload = payload
  end

  def guest_id
    @payload.dig(:reservation, :guest_id)
  end

  def guest_email
    @payload.dig(:reservation, :guest_email)
  end

  def guest_first_name
    @payload.dig(:reservation, :guest_first_name)
  end

  def guest_last_name
    @payload.dig(:reservation, :guest_last_name)
  end

  def guest_phone_numbers
    Array(@payload.dig(:reservation, :guest_phone_numbers))
  end

  def start_at
    @payload.dig(:reservation, :start_date)
  end

  def end_at
    @payload.dig(:reservation, :end_date)
  end

  def no_of_nights
    @payload.dig(:reservation, :nights)
  end

  def status
    @payload.dig(:reservation, :status_type)
  end

  def payout_amount
    @payload.dig(:reservation, :expected_payout_amount)
  end

  def security_amount
    @payload.dig(:reservation, :listing_security_price_accurate)
  end

  def total_amount
    @payload.dig(:reservation, :total_paid_amount_accurate)
  end

  def currency
    @payload.dig(:reservation, :host_currency)
  end
  
  def localized_description
    @payload.dig(:reservation, :guest_details, :localized_description)
  end

  def number_of_guests
    @payload.dig(:reservation, :number_of_guests)
  end

  def number_of_adults
    @payload.dig(:reservation, :guest_details, :number_of_adults)
  end

  def number_of_children
    @payload.dig(:reservation, :guest_details, :number_of_children)
  end

  def number_of_infants
    @payload.dig(:reservation, :guest_details, :number_of_infants)
  end
end
