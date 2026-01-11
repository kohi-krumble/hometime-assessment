FactoryBot.define do
  factory :host, parent: :user do
    email { "host@example.com" }
    first_name { "Host user" }
    user_type { 'host' }
  end
end
