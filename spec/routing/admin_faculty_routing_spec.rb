require "rails_helper"

RSpec.describe Admin::FacultiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/faculties").to route_to("admin/faculties#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/faculties/new").to route_to("admin/faculties#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/faculties/1").to route_to("admin/faculties#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/faculties/1/edit").to route_to("admin/faculties#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/faculties").to route_to("admin/faculties#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/faculties/1").to route_to("admin/faculties#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/faculties/1").to route_to("admin/faculties#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/faculties/1").to route_to("admin/faculties#destroy", :id => "1")
    end

  end
end
