# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do
    Faculty.__elasticsearch__.delete_index! if Faculty.__elasticsearch__.index_exists?
  end

  config.after(:each) do
    Faculty.__elasticsearch__.delete_index! if Faculty.__elasticsearch__.index_exists?
  end
end
