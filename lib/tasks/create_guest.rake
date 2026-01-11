namespace :db do
  task create_guest: :environment do
    email = ENV['email'].presence
    first_name = ENV['first_name'].presence
    phone_number = ENV['phone_number'].presence
    
    guest = Guest.create(email: email, first_name: first_name, phone_numbers: [phone_number])

    if guest.persisted?
      puts "Guest created:"
      puts "ID: #{guest.id}"
      puts "Email: #{guest.email}"
      next
    end

    puts "Failed to create Guest. Errors:"
    puts guest.errors.full_messages

    puts "\nPlease make sure you have the correct task syntax: rake db:create_guest email='your@email.com' first_name='first name' phone_number='639123456789'"
  end
end