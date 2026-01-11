ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
    include FactoryBot::Syntax::Methods
    Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }
  end
end
