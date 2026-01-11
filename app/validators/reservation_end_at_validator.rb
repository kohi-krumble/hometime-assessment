class ReservationEndAtValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if value > record.start_at

    record.errors.add(:end_at, (options[:message] || "must be after the start date"))
  end
end