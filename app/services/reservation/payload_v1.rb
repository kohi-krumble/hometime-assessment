class Reservation::PayloadV1
  def initialize(payload)
    @payload = payload
  end

  def guest_id
    @payload.dig(:guest, :id)
  end

  def guest_email
    @payload.dig(:guest, :email)
  end

  def guest_first_name
    @payload.dig(:guest, :first_name)
  end

  def guest_last_name
    @payload.dig(:guest, :last_name)
  end

  def guest_phone_numbers
    Array(@payload.dig(:guest, :phone))
  end

  def start_at
    @payload[:start_date]
  end

  def end_at
    @payload[:end_date]
  end

  def no_of_nights
    @payload[:nights]
  end

  def status
    @payload[:status]
  end

  def payout_amount
    @payload[:payout_price]
  end

  def security_amount
    @payload[:security_price]
  end

  def total_amount
    @payload[:total_price]
  end

  def currency
    @payload[:currency]
  end
  
  def localized_description
    nil
  end

  def number_of_guests
    @payload[:guests]
  end

  def number_of_adults
    @payload[:adults]
  end

  def number_of_children
    @payload[:children]
  end

  def number_of_infants
    @payload[:infants]
  end
end
