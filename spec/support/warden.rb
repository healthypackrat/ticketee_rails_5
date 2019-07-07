RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :request
  config.after(type: :request) { Warden.test_reset! }

  config.include Warden::Test::Helpers, type: :system
  config.after(type: :system) { Warden.test_reset! }
end
