class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'

  validates :no_of_nights, numericality: { only_integer: true, greater_than: 0 }
  validates :currency, presence: true
  monetize :payout_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :security_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :total_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  validates :details, reservation_details: true
  validates_with ReservationDurationValidator

  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    completed: 'completed'
  }
  attribute :details, Reservation::DetailsType.new
end
