# frozen_string_literal: true

RSpec.describe AdminController, type: :routing do
  context '#get' do
    it 'routes to admin #index' do
      expect(get: '/admin').to route_to('admin#index')
    end
  end
end
