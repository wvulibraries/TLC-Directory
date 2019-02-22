require 'rails_helper'

RSpec.describe Publication, type: :model do
  let(:pub) { FactoryBot.create :publication_user_association }

  it { should belong_to(:publishable) }

  context 'valid object' do
    it 'expects award to be valid' do
      expect(pub).to be_valid
    end
  end

  it 'Starting Year is Nil' do
    pub.starting_year = nil
    expect(pub.starting_year).to be_nil
  end

  it 'Ending Year is Current Year' do
    expect(pub.ending_year).to equal(Time.current.year)
  end

  it 'Valid Display date when all fields are valid' do
    expect(pub.display_date).to eql("(" + pub.starting_year.to_s + ' - ' + pub.ending_year.to_s + ").")
  end

  it 'Without a ending year we should only have starting year' do
    pub.ending_year = nil
    expect(pub.display_date).to eql("(" + pub.starting_year.to_s + ").")
  end

  it 'Should return properly formatted url' do
    expect(pub.retrieved_from).to eql("Retrieved from " + pub.url)
  end

end
