class Guest < User
  default_scope { where(user_type: 'guest') }

  has_many :reservations, foreign_key: 'user_id', class_name: 'Reservation'

  attribute :user_type, :string, default: 'guest'
end
