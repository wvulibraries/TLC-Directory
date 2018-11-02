require 'rails_helper'

RSpec.describe FacultiesController, type: :routing do
  context '#get' do
    it 'routes to #list' do
      expect(get: '/faculties').to route_to('faculties#list')
    end

    it 'routes to #profile' do
      expect(get: '/faculties/1').to route_to('faculties#profile', id: '1')
    end
  end
end