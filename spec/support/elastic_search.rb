RSpec.configure do |config|
  config.before(:each) do
    Faculty.__elasticsearch__.delete_index! if Faculty.__elasticsearch__.index_exists?
    # Building.__elasticsearch__.delete_index! if Employee.__elasticsearch__.index_exists?
    # Department.__elasticsearch__.delete_index! if Employee.__elasticsearch__.index_exists?
  end

  config.after(:each) do
    Faculty.__elasticsearch__.delete_index! if Faculty.__elasticsearch__.index_exists?
    # Building.__elasticsearch__.delete_index! if Employee.__elasticsearch__.index_exists?
    # Department.__elasticsearch__.delete_index! if Employee.__elasticsearch__.index_exists?
  end
end