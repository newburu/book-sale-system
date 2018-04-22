require 'rails_helper'

RSpec.describe "user_authors/index", type: :view do
  before(:each) do
    assign(:user_authors, [
      UserAuthor.create!(
        :user => nil,
        :author => nil
      ),
      UserAuthor.create!(
        :user => nil,
        :author => nil
      )
    ])
  end

  it "renders a list of user_authors" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
