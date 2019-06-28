module CapybaraSupport
  def current_port
    Capybara.current_session.server.port
  end
end

RSpec.configure do |config|
  config.include CapybaraSupport, type: :system
end
