namespace :api do
  task generate_token: :environment do
    token = JwtService.encode(expires_in: 24.hours.from_now)
    puts "Generated JWT token:"
    puts token
  end
end