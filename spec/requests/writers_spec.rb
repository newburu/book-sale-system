require 'rails_helper'

RSpec.describe "Writers", type: :request do
  describe "GET /writers" do
    it "works! (now write some real specs)" do
      get writers_path
      expect(response).to have_http_status(200)
    end
  end
end
