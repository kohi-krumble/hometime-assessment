class ReservationDetailsValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, (options[:message] || "details can't be blank"))
      return
    end

    if !value.has_correct_guest_count?
      record.errors.add(attribute, (options[:message] || "number_of_guests does not match the sum of adults, children, and infants")) 
      return
    end

    if !value.number_of_guests_is_positive?
      record.errors.add(attribute, (options[:message] || "number_of_guests must be positive"))
      return
    end
  end
end