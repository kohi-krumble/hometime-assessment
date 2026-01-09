# frozen_string_literal: true

class Reservation::Details
  ATTRS = %i[localized_description number_of_guests number_of_adults
             number_of_children number_of_infants].freeze
  attr_reader(*ATTRS, :error)

  def initialize(attributes)
    symbolized_attributes = attributes.present? ? attributes.symbolize_keys : {}

    ATTRS.each do |key|
      instance_variable_set("@#{key}", symbolized_attributes[key])
    end
    @error = nil
  end

  def is_guest_count_valid?
    return false if !has_correct_guest_count?
    return false if !number_of_guests_is_positive?
    return true
  end

  def has_correct_guest_count?
    return true if @number_of_guests.to_i == (@number_of_adults.to_i + @number_of_children.to_i + @number_of_infants.to_i)
    
    @error = 'number_of_guests does not match the sum of adults, children, and infants'
    return false
  end

  def number_of_guests_is_positive?
    return true if @number_of_guests.to_i.positive?
    
    @error = 'number_of_guests must be positive'
    return false
  end

  def to_h
    ATTRS.each_with_object({}) do |key, hash|
      hash[key] = send(key)
    end
  end
end
