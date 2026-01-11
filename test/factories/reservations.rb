FactoryBot.define do
  factory :reservation do
    guest { association :guest }
    start_at { Date.today + 1.week }
    end_at { Date.today + 1.week + 3.days }
    no_of_nights { 3 }
    status { "accepted" }
    payout_amount { 3800.00 }
    security_amount { 500 }
    total_amount { 4500.00 }
    currency { "AUD" }
    details { {
      number_of_guests: 4,
      localized_description: "4 guests",
      number_of_adults: 2,
      number_of_children: 2,
      number_of_infants: 0
    } }
  end
end
