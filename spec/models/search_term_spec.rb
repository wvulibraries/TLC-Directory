require 'rails_helper'

RSpec.describe SearchTerm, type: :model do
  let(:search_term) { FactoryBot.create :search_term }

  context 'validations' do
    it { should validate_presence_of(:term) }
    it { should validate_length_of(:term).is_at_least(2) }
    it { should validate_length_of(:term).is_at_most(255) }

    it { should validate_presence_of(:yearmonth) }
    it { should validate_length_of(:yearmonth).is_equal_to(6) }

    it { should validate_presence_of(:term_count) }
    it { should validate_numericality_of(:term_count) }
    it { should_not allow_value(0).for(:term_count) }

  end
end

