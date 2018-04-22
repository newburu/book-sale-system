require 'rails_helper'

RSpec.describe "user_authors/edit", type: :view do
  before(:each) do
    @user_author = assign(:user_author, UserAuthor.create!(
      :user => nil,
      :author => nil
    ))
  end

  it "renders the edit user_author form" do
    render

    assert_select "form[action=?][method=?]", user_author_path(@user_author), "post" do

      assert_select "input[name=?]", "user_author[user_id]"

      assert_select "input[name=?]", "user_author[author_id]"
    end
  end
end
