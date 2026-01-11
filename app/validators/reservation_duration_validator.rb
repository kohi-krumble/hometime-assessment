class ReservationDurationValidator < ActiveModel::Validator

  def validate(record)
    if record.start_at.blank?
      record.errors.add(:start_at, "can't be blank")
      return
    end

    if record.start_at <= Date.current
      record.errors.add(:start_at, (options[:message] || "must be greater than #{Date.current}"))
      return
    end

    if record.end_at.blank?
      record.errors.add(:end_at, "can't be blank")
      return
    end

    if record.end_at <= record.start_at
      record.errors.add(:end_at, (options[:message] || "must be after the start date"))
      return
    end

    scope = Reservation.accepted.where("start_at < ? AND end_at > ?", record.end_at, record.start_at)
    scope = scope.where.not(id: record.id) if !record.new_record?
    # no overlap
    return if scope.none?
    
    record.errors.add(:base, (options[:message] || "selected date is not available"))
  end
end