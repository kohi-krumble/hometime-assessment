class Reservation < ApplicationRecord
  validates :start_date, comparison: { greater_than: -> { Date.current } }
  validates :end_date_after_start_date
  validates :no_of_nights, numericality: { only_integer: true, greater_than: 0 }
  validates :currency, presence: true
  monetize :payout_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :security_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :total_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }

  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    completed: 'completed'
  }

  private

  def end_date_after_start_date
    return if end_date > start_date

    errors.add(:end_date, 'must be after the start date')
  end
end
