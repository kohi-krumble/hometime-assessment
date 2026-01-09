class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'

  validates :start_at, comparison: { greater_than: -> { Date.current } }
  validate :end_at_after_start_at
  validates :no_of_nights, numericality: { only_integer: true, greater_than: 0 }
  validates :currency, presence: true
  monetize :payout_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :security_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  monetize :total_amount_cents, with_model_currency: :currency,
           numericality: { greater_than_or_equal_to: 0 }
  validate :details_number_of_guests_consistency

  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    completed: 'completed'
  }

  attribute :details, Reservation::DetailsType.new

  private

  def end_at_after_start_at
    return if end_at > start_at

    errors.add(:end_at, 'must be after the start date')
  end

  def details_number_of_guests_consistency
    return if details.is_guest_count_valid?

    errors.add(:details, details.error)
  end
end
