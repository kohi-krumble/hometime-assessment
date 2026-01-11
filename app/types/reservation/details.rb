# frozen_string_literal: true

class Reservation::Details
  ATTRS = %i[localized_description number_of_guests number_of_adults
             number_of_children number_of_infants].freeze
  attr_reader(*ATTRS)

  def initialize(attributes)
    attributes.symbolize_keys!

    ATTRS.each do |key|
      instance_variable_set("@#{key}", attributes[key])
    end
  end

  def has_correct_guest_count?
    @number_of_guests.to_i == (@number_of_adults.to_i + @number_of_children.to_i + @number_of_infants.to_i)
  end

  def number_of_guests_is_positive?
    @number_of_guests.to_i.positive?
  end

  def to_h
    ATTRS.each_with_object({}) do |key, hash|
      hash[key] = instance_variable_get("@#{key}")
    end
  end
end
