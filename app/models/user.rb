class User < ApplicationRecord
  validates_presence_of :first_name
  validates :email, presence: true, uniqueness: true, email: true
  validates :phone_numbers, user_phone_numbers: true

  enum user_type: {
    guest: 'guest',
    host: 'host'
  }

  attribute :phone_numbers, User::PhoneNumbersType.new
end
