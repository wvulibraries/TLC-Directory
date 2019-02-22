require 'rails_helper'

RSpec.describe Award, type: :model do
  let(:award) { FactoryBot.create :award_user_association }

  it { should belong_to(:awardable) }

  context 'validations' do
    it { should validate_length_of(:description).is_at_most(500) }
  end

  context 'valid object' do
    it 'expects award to be valid' do
      expect(award).to be_valid
    end
  end

  it 'Starting Year is Nil' do
    award.starting_year = nil
    expect(award.starting_year).to be_nil
  end

  it 'Ending Year is Current Year' do
    expect(award.ending_year).to equal(Time.current.year)
  end

  it 'Valid Display Award when all fields are valid' do
    expect(award.display_award).to eql(award.starting_year.to_s + ' - ' + award.ending_year.to_s + ' ' + award.name + ', ' + award.organization)
  end

  it 'Without a ending year we should only have starting year and description on display award' do
    award.ending_year = nil
    expect(award.display_award).to eql(award.starting_year.to_s + ' ' + award.name + ', ' + award.organization)
  end

  it 'Without a name should just display starting and ending year, name and organizationo from display award' do
    award.name = nil
    expect(award.display_award).to eql(award.starting_year.to_s + ' - ' + award.ending_year.to_s + ' ' + award.organization)
  end

  it 'Without a organization should just display starting and ending year, name from display award' do
    award.organization = nil
    expect(award.display_award).to eql(award.starting_year.to_s + ' - ' + award.ending_year.to_s + ' ' + award.name)
  end

  it 'Without a Starting Year should display name and organization' do
    award.starting_year = nil
    expect(award.display_award).to eql(award.name + ', ' + award.organization)
  end

end
