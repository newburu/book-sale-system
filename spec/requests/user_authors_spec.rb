require 'rails_helper'

RSpec.describe "UserAuthors", type: :request do
  describe "GET /user_authors" do
    it "works! (now write some real specs)" do
      get user_authors_path
      expect(response).to have_http_status(200)
    end
  end
end
