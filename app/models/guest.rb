class Guest < User
  has_many :reservations, foreign_key: 'user_id', class_name: 'Reservation'
end
