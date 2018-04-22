require "rails_helper"

RSpec.describe UserAuthorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_authors").to route_to("user_authors#index")
    end

    it "routes to #new" do
      expect(:get => "/user_authors/new").to route_to("user_authors#new")
    end

    it "routes to #show" do
      expect(:get => "/user_authors/1").to route_to("user_authors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_authors/1/edit").to route_to("user_authors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_authors").to route_to("user_authors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_authors/1").to route_to("user_authors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_authors/1").to route_to("user_authors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_authors/1").to route_to("user_authors#destroy", :id => "1")
    end

  end
end
