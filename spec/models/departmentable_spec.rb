require 'rails_helper'

RSpec.describe Departmentable, type: :model do
  context 'associations' do
    it { should belong_to(:department) }
    it { should belong_to(:faculty) }
  end 
end
