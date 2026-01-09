class User < ApplicationRecord
  validates_presence_of :first_name
  validates :email, presence: true, uniqueness: true,
            format: { with: Rails.application.config.email_regex }
  validate :all_phone_number_must_be_valid

  private

  def all_phone_number_must_be_valid
    return errors.add(:phone_numbers, "should have at least one phone number") if phone_numbers.blank?

    phone_numbers.each do |phone_number|
      if phone_number !~ /\A\d{12}\z/
        errors.add(:phone_numbers, "#{phone_number} is not valid") 
      end
    end
  end
end
