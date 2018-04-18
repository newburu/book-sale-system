require "rails_helper"

RSpec.describe UserWritersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_writers").to route_to("user_writers#index")
    end

    it "routes to #new" do
      expect(:get => "/user_writers/new").to route_to("user_writers#new")
    end

    it "routes to #show" do
      expect(:get => "/user_writers/1").to route_to("user_writers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_writers/1/edit").to route_to("user_writers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_writers").to route_to("user_writers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_writers/1").to route_to("user_writers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_writers/1").to route_to("user_writers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_writers/1").to route_to("user_writers#destroy", :id => "1")
    end

  end
end
