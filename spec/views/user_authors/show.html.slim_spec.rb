require 'rails_helper'

RSpec.describe "user_authors/show", type: :view do
  before(:each) do
    @user_author = assign(:user_author, UserAuthor.create!(
      :user => nil,
      :author => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
