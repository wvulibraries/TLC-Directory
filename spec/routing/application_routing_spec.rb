require 'rails_helper'

RSpec.describe ApplicationController, type: :routing do
  context 'Basic application routing' do
    it 'routes to #index' do
      expect(get: '/').to route_to('application#home')
      expect(get: '/home').to route_to('application#home')
    end
  end

  context 'logging in' do
    it 'routes to the login url' do
      expect(get: '/login').to route_to('application#login')
    end 
  end 
end