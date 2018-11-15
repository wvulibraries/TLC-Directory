require 'rails_helper'

RSpec.describe Collegeable, type: :model do
  context 'associations' do
    it { should belong_to(:college) }
    it { should belong_to(:faculty) }
  end 
end
