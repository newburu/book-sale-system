require 'rails_helper'

RSpec.describe "UserWriters", type: :request do
  describe "GET /user_writers" do
    it "works! (now write some real specs)" do
      get user_writers_path
      expect(response).to have_http_status(200)
    end
  end
end
