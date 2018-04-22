require 'rails_helper'

RSpec.describe "user_authors/new", type: :view do
  before(:each) do
    assign(:user_author, UserAuthor.new(
      :user => nil,
      :author => nil
    ))
  end

  it "renders new user_author form" do
    render

    assert_select "form[action=?][method=?]", user_authors_path, "post" do

      assert_select "input[name=?]", "user_author[user_id]"

      assert_select "input[name=?]", "user_author[author_id]"
    end
  end
end
